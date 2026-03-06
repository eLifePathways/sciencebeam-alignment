VENV = .venv
UV = VIRTUAL_ENV=$(VENV) uv
UV_PIP = $(UV) pip
PYTHON = $(VENV)/bin/python

NOT_SLOW_PYTEST_ARGS = -m 'not slow'

ARGS =


.PHONY: build


venv-clean:
	@if [ -d "$(VENV)" ]; then \
		rm -rf "$(VENV)"; \
	fi


venv-create:
	$(UV) venv $(VENV)


dev-install:
	$(UV) sync


dev-cython-clean:
	rm -f sciencebeam_alignment/align_fast_utils.c sciencebeam_alignment/align_fast_utils.so


dev-cython-compile:
	$(PYTHON) setup.py build_ext --inplace


dev-venv: venv-create dev-install dev-cython-compile


dev-flake8:
	$(PYTHON) -m flake8 sciencebeam_alignment tests setup.py


dev-pylint:
	$(PYTHON) -m pylint sciencebeam_alignment tests setup.py


dev-lint: dev-flake8 dev-pylint


dev-pytest:
	$(PYTHON) -m pytest -p no:cacheprovider $(ARGS)


dev-watch:
	$(PYTHON) -m pytest_watch -- -p no:cacheprovider $(ARGS)


dev-test: dev-lint dev-pytest
