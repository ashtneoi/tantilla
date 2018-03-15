from functools import partial

from werkzeug.exceptions import abort, HTTPException, NotFound
from werkzeug.routing import Map, Rule

def create_app(mount_point, url_map):
    url_map = Map(
        [Rule(mount_point + path, endpoint=ep) for (path, ep) in url_map]
    )
    def app(environ, start_response):
        try:
            endpoint, values = url_map.bind_to_environ(environ).match()
            with Request(environ) as req:
                if req.method not in ('GET', 'POST'):
                    return abort(400)(environ, start_response)
                return endpoint(req)(environ, start_response)
        except NotFound:
            with open("special/404.html") as f:
                return HTMLResponse(
                    f.read(), status=404,
                )(environ, start_response)
        except HTTPException as e:
            return e(environ, start_response)
    return app
