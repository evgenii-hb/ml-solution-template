install_poetry:
	make install_poetry_zsh

install_poetry_zsh:
	curl -sSL https://install.python-poetry.org | python3 -
	echo "export PATH=\"/Users/$$(whoami)/.local/bin:\$$PATH\"" >> ~/.zshrc && \
	source ~/.zshrc && \
	mkdir -p ~/.zfunc && \
	poetry completions zsh > ~/.zfunc/_poetry && \
	echo "fpath+=~/.zfunc" >> ~/.zshrc && \
	echo "autoload -Uz compinit && compinit" >> ~/.zshrc && \
	poetry --version

build:
	docker build --target production -t change_docker_image_name -t change_docker_image_name:3.11.4-slim .
	docker build --target development -t change_docker_image_name:dev -t change_docker_image_name:3.11.4-slim-dev .
	docker image list
	
clear_build_cache:
	docker system prune -f

test:
	poetry run coverage run -m pytest
	poetry run coverage report -m

lint:
	poetry run black --check . && \
	poetry run ruff . && \
	poetry run mypy .

run:
	docker run --rm change_docker_image_name

run_checks:
	docker run --rm change_docker_image_name:dev bash -c " \
	echo \"=== pytest ===\" && \
	poetry run coverage run -m pytest -v . && \
	poetry run coverage report -m && \
	echo \"=== black ===\" && \
	poetry run black --check . && \
	echo \"=== ruff ===\" && \
	poetry run ruff . && \
	echo \"=== mypy ===\" && \
	poetry run mypy . \
	"
