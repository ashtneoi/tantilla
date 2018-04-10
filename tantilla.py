from functools import partial

from werkzeug.exceptions import abort, HTTPException, NotFound
from werkzeug.routing import Map, Rule
from werkzeug.wrappers import Request, Response


HTMLResponse = partial(Response, content_type='text/html')


def create_app(mount_point, url_map):
    url_map = Map(
        [Rule(mount_point + path, endpoint=ep) for (path, ep) in url_map]
    )
    def app(environ, start_response):
        with Request(environ) as req:
            try:
                endpoint, values = url_map.bind_to_environ(environ).match()
                if req.method not in ('GET', 'POST'):
                    return abort(400)(environ, start_response)
                response = endpoint(req)
            except NotFound:
                with open("special/404.html") as f:
                    response = HTMLResponse(
                        f.read(), status=404,
                    )
            except HTTPException as e:
                response = e
            return response(environ, start_response)
    return app
