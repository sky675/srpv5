from distutils.core import setup
import py2exe

setup(
    zipfile = None,
    windows = [{
            "script":"main.pyw",
            "icon_resources": [(1, "progicon.ico")],
            "dest_base":"Log Examiner"
            }],
)