# syntax=docker/dockerfile:1

# Based on: https://github.com/orgs/python-poetry/discussions/1879
# `python-base` sets up all our shared environment variables
FROM python:3.10.12-slim as python-base

# Default to the latest version of Poetry
ARG POETRY_VERSION="1.5.1"

ENV POETRY_VERSION=${POETRY_VERSION} \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1

ENV PATH="$POETRY_HOME/bin:$PATH"

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=0 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_DEFAULT_TIMEOUT=100 \
    # this is where our requirements + virtual environment will live
    PROJECT_PATH="/opt/project" \
    VENV_PATH="/opt/project/.venv"

# prepend poetry and venv to path
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

# --- POETRY ----

# `builder-base` stage is used to build deps + create our virtual environment
FROM python-base as builder-base
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        # deps for installing poetry
        curl \
        # deps for building python deps
        build-essential

# install poetry - respects $POETRY_VERSION & $POETRY_HOME
RUN curl -sSL https://install.python-poetry.org | python3 -

# copy project requirement files here to ensure they will be cached.
WORKDIR $PROJECT_PATH
COPY poetry.lock pyproject.toml ./

# install runtime deps - uses $POETRY_VIRTUALENVS_IN_PROJECT internally
RUN poetry install --only=main --no-root

# --- PROD ---

# `production` image used for runtime
FROM python-base as production

# copy in our built poetry + venv
COPY --from=builder-base $POETRY_HOME $POETRY_HOME
COPY --from=builder-base $PROJECT_PATH $PROJECT_PATH

WORKDIR $PROJECT_PATH
COPY README.md ./
COPY change_lib_name ./change_lib_name
RUN poetry install --only-root --compile

CMD ["poetry", "run", "python", "-m", "change_lib_name"]

# --- DEV ----

FROM production as development

# See: https://github.com/orgs/python-poetry/discussions/1879#discussioncomment-2169007
ENV PYTHONDONTWRITEBYTECODE=1

WORKDIR $PROJECT_PATH
COPY tests ./tests

# quicker install as runtime deps are already installed
RUN poetry install --only=dev,test --compile
CMD ["poetry", "run", "pytest", "-v"]


