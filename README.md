# ML Solution

> Python template for data solution repository used by a data science team or ML engineering team.

After creating new repository do not forget to change the names and description of project. Look for the following:

- `change_lib_name` in Python files, Dockerfile
- `change_docker_image_name` in Makefile and any versions if needed
- first lines in `pyproject.toml` and any other configs if needed
- update project requirements via `poetry add` and  `poetry remove`

Run `poetry update` to get latest version of packages you need. This will install **all** packages and write new lock file.

Run `poetry env info`. It should display information about virtual environment Poetry using. You should see some Python 3.10 version.

Run `poetry run python -m change_lib_name` to see if template works as expected. Put your name instead of `change_lib_name` if you have changed it.

Look inside Makefile for more usefull command. Now you are ready to put your code into the template.

# Prerequisites

### Poetry

The project uses [Poetry](https://python-poetry.org/docs/master/basic-usage/) for dependecy and virtual environment management, and packaging. If you are on Mac run:

```zsh
make install_poetry
```

For other systems refer to official [Poetry documentation](https://python-poetry.org/docs/#installation).

# Installation

## For runtime

```sh
poetry install --only=main
```

## For development
```
poetry install
```

This will install **all** non-main dependencies and the project in editable mode by default. If you need only dev dependencies:

```
poetry install --only=main,dev
```

# Development info

Follow PEP8 while writing code. The project utilizes `black` for formatting, `mypy` for type checks and `ruff` for linting. You can find configuration for either of those in `pyproject.toml`.

# Repository description

### .gitignore

The project has all-at-once type of gitignore with little to none changes required.

### .pre-commit-config.yaml

The project has the following checks:

- Check that file size does not exceed 512KB
- General yaml and toml checks
- Poetry check of `pyproject.toml`
- [Black](https://github.com/psf/black), [ruff](https://github.com/astral-sh/ruff), [mypy](https://github.com/python/mypy) checks
- [GitGuardian](https://github.com/GitGuardian/ggshield) sensistive data checks

### Makefile

Contains Poetry installation for macOS and other scripts for CICD.

### poetry.lock

Resolved dependencies by poetry. More on that in poetry [documentation](https://python-poetry.org/docs/basic-usage/#installing-dependencies).

### pyproject.toml

Single source for project configuration. All dependencies including possible extras are managed by poetry. Apart from that includes configuration for `ruff`, `black`, and `mypy`.

There are 3 [dependecy groups](https://python-poetry.org/docs/managing-dependencies/#dependency-groups) at the moment:

- main : this is runtime dependencies
- dev : includes linters, formatters, and pre-commit
- test : includes pytest and coverage utils
- jn : Jupyter notebook and plotting utils

This project does not utilize package extras.
