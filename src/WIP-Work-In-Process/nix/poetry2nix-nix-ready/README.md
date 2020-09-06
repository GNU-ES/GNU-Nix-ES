##

[poetry2nix](https://github.com/nix-community/poetry2nix)


[Nix Friday - poetry2nix part 1](https://www.youtube.com/watch?v=XfqJulSAPBQ)
[Nix Friday - poetry2nix part 2](https://www.youtube.com/watch?v=XzxvChwMRVY)

`docker build --tag pedroregispoar/nixos/poetry2nix .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nixos/poetry2nix
```

Create the `shell.nix` file with the below code:
```
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.python3
      pkgs.poetry
    ];
}
```

In the Docker shell run: 

```
a092b5e8ca4a:/code# nix-shell
[nix-shell:/code]# 
```

You can check for a python instalation:
```
[nix-shell:/code]# python
Python 3.7.7 (default, Mar 10 2020, 06:34:06) 
[GCC 9.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> 
```

And for a poetry intalation:
```
[nix-shell:/code]# poetry --version
Poetry version 1.0.5
```


```
[nix-shell:/code]# poetry init

This command will guide you through creating your pyproject.toml config.

Package name [code]: nixfriday
Version [0.1.0]:  
Description []:  
Author [None, n to skip]:  n
License []:  MIT
Compatible Python versions [^3.7]:  

Would you like to define your main dependencies interactively? (yes/no) [yes] 
You can specify a package in the following forms:
  - A single name (requests)
  - A name and a constraint (requests ^2.23.0)
  - A git url (git+https://github.com/python-poetry/poetry.git)
  - A git url with a revision (git+https://github.com/python-poetry/poetry.git#develop)
  - A file path (../my-package/my-package.whl)
  - A directory (../my-package/)
  - An url (https://example.com/packages/my-package-0.1.0.tar.gz)

Search for package to add (or leave blank to continue): flask
Found 20 packages matching flask

Enter package # to add, or the complete package name if it is not listed: 
 [0] Flask
 [1] Flask-Zipper
 [2] flask-beans
 [3] Flask-Sessions
 [4] Flask-SimpleACL
 [5] Flask-Lock
 [6] Flask-Shelve
 [7] Flask-Account
 [8] Flask-OpenID
 [9] flask-pwa
 > 0
Enter the version constraint to require (or leave blank to use the latest version): 
Using version ^1.1.2 for Flask

Add a package: 

Would you like to define your development dependencies interactively? (yes/no) [yes] 
Search for package to add (or leave blank to continue): pytest
Found 20 packages matching pytest

Enter package # to add, or the complete package name if it is not listed: 
 [0] pytest
 [1] pytest123
 [2] 131228_pytest_1
 [3] pytest-symbols
 [4] pytest-circleci
 [5] pytest-bigchaindb
 [6] pytest-parallel
 [7] pytest-level
 [8] pytest-grpc
 [9] pytest-pythonpath
 > 0
Enter the version constraint to require (or leave blank to use the latest version): 
Using version ^5.4.3 for pytest

Add a package: 

Generated file

[tool.poetry]
name = "nixfriday"
version = "0.1.0"
description = ""
authors = ["Your Name <you@example.com>"]
license = "MIT"

[tool.poetry.dependencies]
python = "^3.7"
flask = "^1.1.2"

[tool.poetry.dev-dependencies]
pytest = "^5.4.3"

[build-system]
requires = ["poetry>=0.12"]
build-backend = "poetry.masonry.api"


Do you confirm generation? (yes/no) [yes]
```



```
[nix-shell:/code]# poetry lock
Creating virtualenv nixfriday-MATOk_fk-py3.7 in /root/.cache/pypoetry/virtualenvs
Updating dependencies
Resolving dependencies... (21.5s)

Writing lock file
```

Looks like it is possible star a boiler plate at least from here?
# TODO: add environment variable to disable virtual environment creation

```
a092b5e8ca4a:/code# nix-shell
...
[nix-shell:/code]# python
Python 3.7.7 (default, Mar 10 2020, 06:34:06) 
[GCC 9.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import flask
>>> 
```

Crate a file named `nixfryday.py`

``` 
from flask import Flask

if __name__ == '__main__':
    print('Hello world!!')
```

```
[nix-shell:/code]# python nixfriday.py
Hello world!!
```

TODO:
curl http://localhost:5000

```
[nix-shell:/code]# poetry build
Building nixfriday (0.1.0)
 - Building sdist
 - Built nixfriday-0.1.0.tar.gz

 - Building wheel
 - Built nixfriday-0.1.0-py3-none-any.whl
```



```
[nix-shell:/code]# python nixfryday.py
 * Serving Flask app "nixfryday" (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
```


Create a file `default.nix` with the following content:

```
{ pkgs ? import <nixpkgs> {} }:
pkgs.poetry2nix.mkPoetryApplication {
    poetrylock = ./poetry.lock;
    pyproject = ./pyproject.toml;
    python = pkgs.python3;
    src = pkgs.lib.cleanSource ./.;
}
```

```
[nix-shell:/code]# nix-build --no-link ./default.nix
...
/nix/store/f6qwi8cx4h97fjaabcjcn537vphkq9kd-nixfriday-0.1.0
```

```
[nix-shell:/code]# find /nix/store/f6qwi8c*
...
```


```
[nix-shell:/code]# nix-build ./default.nix
```

```
[nix-shell:/code]# cat result/bin/nixfriday 
#! /nix/store/kgp3vq8l9yb8mzghbw83kyr3f26yqvsz-bash-4.4-p23/bin/bash -e
export PATH='/nix/store/ihy2vly61ndky6qlv1q4dfdiv28vszkh-python3-3.7.7/bin:/nix/store/ia6mbh9limdbwa4dn4xzvmlbr8ybfvym-nixfriday-0.1.0/bin:/nix/store/7l8j20lyyh0f3p004c158yiiw4gbpzrs-python3.7-flask-1.1.2/bin:/nix/store/wqrpi0di1jb17gmzim8j58rznz4v6wqf-python3.7-setuptools-45.2.0/bin'${PATH:+':'}$PATH
export PYTHONNOUSERSITE='true'
exec -a "$0" "/nix/store/ia6mbh9limdbwa4dn4xzvmlbr8ybfvym-nixfriday-0.1.0/bin/.nixfriday-wrapped"  "$@"
```

```
[nix-shell:/code]# cat result/bin/.nixfriday-wrapped 
#!/nix/store/ihy2vly61ndky6qlv1q4dfdiv28vszkh-python3-3.7.7/bin/python3.7
# -*- coding: utf-8 -*-
import sys;import site;import functools;sys.argv[0] = '/nix/store/ia6mbh9limdbwa4dn4xzvmlbr8ybfvym-nixfriday-0.1.0/bin/nixfriday';functools.reduce(lambda k, p: site.addsitedir(p, k), ['/nix/store/ia6mbh9limdbwa4dn4xzvmlbr8ybfvym-nixfriday-0.1.0/lib/python3.7/site-packages','/nix/store/7l8j20lyyh0f3p004c158yiiw4gbpzrs-python3.7-flask-1.1.2/lib/python3.7/site-packages','/nix/store/r462392zcnv7vkm9z5hyc54dq7hbysmw-python3.7-jinja2-2.11.2/lib/python3.7/site-packages','/nix/store/bpy7b22k53pyd3bc5gjl9b5rwph2s0fv-python3.7-markupsafe-1.1.1/lib/python3.7/site-packages','/nix/store/kydgyjz34plqkmxvd3a73vgkgivj9h13-python3.7-werkzeug-1.0.1/lib/python3.7/site-packages','/nix/store/qnd1i3slxmdyyfagvpnw75512jw6n5aa-python3.7-click-7.1.2/lib/python3.7/site-packages','/nix/store/wkpxiis5za1fddmzcqvz1kp52m2h401s-python3.7-itsdangerous-1.1.0/lib/python3.7/site-packages','/nix/store/wqrpi0di1jb17gmzim8j58rznz4v6wqf-python3.7-setuptools-45.2.0/lib/python3.7/site-packages'], site._init_pathinfo());
import re
import sys
from nixfriday import main
if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw|\.exe)?$', '', sys.argv[0])
    sys.exit(main())
```

```
[nix-shell:/code]# ./result/bin/nixfriday 
 * Serving Flask app "nixfriday" (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
```

TODO:

python = pkgs.python3;

->

python = pkgs.python35;

And rebuild!


Open source projects shoud ship only code, not binarys.
14:15
https://www.youtube.com/watch?v=XzxvChwMRVY


IRC

```
{ pkgs ? import <nixpkgs> {} }:
pkgs.poetry2nix.mkPoetryApplication {
    poetrylock = ./poetry.lock;
    pyproject = ./pyproject.toml;
    python = pkgs.python3;
    src = pkgs.lib.cleanSource ./.;
    
    overrides = [
        pkgs.poetry2nix.defaultPoetryOverrides
        (self: super: {
            flask = super.flask.overrideAttrs(old: {
                preConfigure = ''
                    ${pkgs.cowsay}/bin/cowsay "Moooo"
                    sleep 2
                ''
            });
        })
    ];
}
```



nix-store --query --references /nix/store/hl1zvb0slvpx5jnzh55m8fyldsjwnwpz-nixfriday-0.1.0.drv

nix-store --query --references /nix/store/6vc8qh0w0dq6xpwf5n0x6ixgzws3cm5q-nixfriday-0.1.0
