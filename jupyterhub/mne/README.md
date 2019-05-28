## MNE

Used during MNE-Workshop at Brown University on April 5, 2019.
The contents of the workshop live [here](https://jasmainak.github.io/mne-workshop-brown/readme)

## Build Notes:

It wasn't straight forward to get MNE dependecies installed, in particular Mayavi. For Mayavi to work on our JupyterHub set up, it was necessary to have an X server running. This was accomplished by installing `apt-get install xvfb` and changing the entrypoint of the docker container to `ENTRYPOINT ["tini", "-g", "--", "xvfb-run"]`

This Docker image uses Python 3.7, Mayavi 4.6.2, PyQt5 5.12.1, VTK 8.1.2. Note that PyQT5 also requiered `apt-get install qt5-default` to find it's plugins correctly.

Currently only `mayavi.init_notebook('png')` works. The x3d backend produces empty plots.


