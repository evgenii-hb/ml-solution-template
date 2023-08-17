# ML Solution

> Python template for a data solution repository used by a data science team or an ML engineering team.

After creating a new repository, don't forget to change the names and description of the project. Look for the following:

- `change_lib_name` in Python files, Dockerfile, and the folder name of the package itself.
- `change_docker_image_name` in the Makefile and adjust any versions if necessary.
- First lines in `pyproject.toml` and any other configurations if needed.
- Update project requirements using `poetry add` and `poetry remove`.

# Quickstart

Run `poetry update` to get the latest version of the packages you need. This will install **all** packages and write a new lock file.

Run `poetry env info`. It should display information about the virtual environment Poetry is using. You should see the Python 3.10 version.

Run `poetry run python -m change_lib_name` to see if the template works as expected. Replace `change_lib_name` with the appropriate name if you've changed it.

Look inside the Makefile for more useful commands. Now you're ready to integrate your code into the template.

# Prerequisites

### Poetry

The project uses [Poetry](https://python-poetry.org/docs/master/basic-usage/) for dependency, virtual environment management, and packaging. If you're on a Macbook, run:

```zsh
make install_poetry
```

For other systems, refer to the official [Poetry documentation](https://python-poetry.org/docs/#installation).

# Installation

## For Runtime

```sh
poetry install --only=main
```

## For Development
```
poetry install
```

This will install **all** non-main dependencies and the project in editable mode by default. If you only need dev dependencies:

```
poetry install --only=main,dev
```

# Development Info

Follow PEP8 while writing code. The project uses `black` for formatting, `mypy` for type checks, and `ruff` for linting. You can find the configuration for each of these in `pyproject.toml`.

# Repository Description

### .gitignore

The project has an all-at-once type of gitignore with few to no changes required.

### .pre-commit-config.yaml

`pre-commit` itself will be installed by poetry. You should set it up it as follows:
```zsh
poetry run pre-commit install
```

Then you can call it as
```zsh
poetry run pre-commit run --all-files
```

The project includes the following checks:

- Check that file size does not exceed 512KB
- General yaml and toml checks
- Poetry check of `pyproject.toml`
- [Black](https://github.com/psf/black), [ruff](https://github.com/astral-sh/ruff), [mypy](https://github.com/python/mypy) checks

### Makefile

Contains Poetry installation for macOS and other scripts for CI/CD.

### poetry.lock

Resolved dependencies by poetry. More on that in the poetry [documentation](https://python-poetry.org/docs/basic-usage/#installing-dependencies).

### pyproject.toml

Single source for project configuration. All dependencies, including possible extras, are managed by poetry. It also includes configuration for `ruff`, `black`, and `mypy`.

There are 3 additional [dependency groups](https://python-poetry.org/docs/managing-dependencies/#dependency-groups) at the moment:

- main: runtime dependencies
- dev: includes linters, formatters, and pre-commit
- test: includes pytest and coverage utilities
- jn: Jupyter notebook and plotting utilities

This project does not utilize package extras.
