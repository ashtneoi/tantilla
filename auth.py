import datetime
from base64 import b64encode
from functools import wraps
from os import urandom

import toml
from werkzeug.urls import url_quote
from werkzeug.utils import redirect

from config import config
from pw import checkpw


secrets = toml.load("secrets.toml")
users = secrets['users']

COOKIE_NAME = 'id' + config['mount_point'].replace('/', '_')


class AuthManager():
    USER_NOT_FOUND = "USER_NOT_FOUND"  # TODO: use Constant instead
    PW_WRONG = "PW_WRONG"

    def __init__(self, mount_point):
        self.sessions = {}  # id: (username, expiration)
        self.mount_point = mount_point

    def abs_to_rel(self, path):
        # TODO: this is kind of a gross place for this
        if path[:len(self.mount_point)] == self.mount_point:
            return path[len(self.mount_point):]
        return path

    def cookie_to_username(self, id_):
        session = self.sessions.get(id_)
        if session is None:
            return None
        username, expiration = session
        if username in users and expiration > datetime.datetime.now():
            return username
        else:
            del self.sessions[id_]
            return None

    def require_auth(self, func):
        @wraps(func)
        def new_func(req, *args, **kwargs):
            username = self.cookie_to_username(req.cookies.get(COOKIE_NAME))
            if username:
                return func(req, username, *args, **kwargs)
            else:
                resp = redirect(
                    self.mount_point + "login?from=" + url_quote(
                        self.abs_to_rel(req.full_path)
                    ),
                    code=303,
                )
                resp.delete_cookie(COOKIE_NAME)
                return resp
        return new_func

    def require_auth_static(self, name):
        @auth_mgr.require_auth
        def inner(req, username):
            with open(name) as f:
                return HTMLResponse(
                    f.read()
                )
        return inner

    def try_log_in(self, username, password):
        hashed = users.get(username)
        if hashed is None:
            return self.USER_NOT_FOUND
        if not checkpw(password, hashed.encode('ascii')):
            return self.PW_WRONG

        sessions2 = self.sessions.copy()
        for id_ in sessions2:
            _, expiration = sessions2[id_]
            if expiration <= datetime.datetime.now():
                del self.sessions[id_]

        id_ = b64encode(urandom(32)).decode('ascii')
        assert id_ not in self.sessions  # until I verify this works
        expiration = datetime.datetime.now() + datetime.timedelta(days=60)
        self.sessions[id_] = (username, expiration)

        return id_, expiration
