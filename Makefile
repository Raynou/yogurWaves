.PHONY: help install test lint format fix clean all

help:
	@echo "Available commands:"
	@echo "  make install    - Install project dependencies"
	@echo "  make lint       - Run linting checks (flake8 + pycodestyle)"
	@echo "  make format     - Check code formatting"
	@echo "  make fix        - Auto-fix formatting issues"
	@echo "  make clean      - Remove cache files and tox environments"
	@echo "  make all        - Fix formatting and run all tests"

install:
	pip install -r requirements.txt
	pip install tox pycodestyle flake8 autopep8

lint:
	tox -e flake8,pycodestyle

format:
	@echo "Checking code formatting..."
	autopep8 --diff --aggressive --aggressive -r .

fix:
	@echo "Auto-fixing code formatting..."
	autopep8 --in-place --aggressive --aggressive -r .
	@echo "✓ Code formatted successfully!"

clean:
	@echo "Cleaning up..."
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type f -name "*.coverage" -delete
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".tox" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	@echo "✓ Cleanup complete!"

all: fix test
	@echo "✓ All checks passed!"