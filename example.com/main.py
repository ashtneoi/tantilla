from bakery import render_path
from config import MOUNT_POINT
from tantilla import create_app, HTMLResponse


def hello(req, username):
    if req.method == 'POST':
        return abort(400)
    return HTMLResponse(
        render_path("tmpl/hello.htmo", {
            "base": MOUNT_POINT,
            "title": "hey",
        }),
    )


application = create_app(MOUNT_POINT, (
    ("", hello),
))
