# VMware vSphere 7 Learning Hub - Makefile
# Enterprise-grade automation and development workflows

.PHONY: help install test lint security clean docs deploy validate setup-dev

# Default target
.DEFAULT_GOAL := help

# Variables
PYTHON := python3
PIP := pip3
VENV := venv
REQUIREMENTS := requirements.txt
SRC_DIR := scripts
DOCS_DIR := docs
TEST_DIR := tests

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
PURPLE := \033[0;35m
CYAN := \033[0;36m
WHITE := \033[0;37m
NC := \033[0m # No Color

help: ## Show this help message
	@echo "$(CYAN)VMware vSphere 7 Learning Hub - Available Commands$(NC)"
	@echo "=================================================="
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "$(GREEN)%-20s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install all dependencies
	@echo "$(BLUE)Installing dependencies...$(NC)"
	$(PIP) install --upgrade pip
	$(PIP) install -r $(REQUIREMENTS)
	@echo "$(GREEN)✅ Dependencies installed successfully$(NC)"

setup-dev: ## Setup development environment
	@echo "$(BLUE)Setting up development environment...$(NC)"
	$(PYTHON) -m venv $(VENV)
	. $(VENV)/bin/activate && $(PIP) install --upgrade pip
	. $(VENV)/bin/activate && $(PIP) install -r $(REQUIREMENTS)
	. $(VENV)/bin/activate && $(PIP) install pre-commit
	. $(VENV)/bin/activate && pre-commit install
	@echo "$(GREEN)✅ Development environment setup complete$(NC)"

validate: ## Validate all scripts and configurations
	@echo "$(BLUE)Validating repository structure...$(NC)"
	@if [ ! -f "README.md" ]; then echo "$(RED)❌ README.md not found$(NC)"; exit 1; fi
	@if [ ! -f "LICENSE" ]; then echo "$(RED)❌ LICENSE not found$(NC)"; exit 1; fi
	@if [ ! -d "$(SRC_DIR)" ]; then echo "$(RED)❌ Scripts directory not found$(NC)"; exit 1; fi
	@if [ ! -d "$(DOCS_DIR)" ]; then echo "$(RED)❌ Documentation directory not found$(NC)"; exit 1; fi
	@echo "$(GREEN)✅ Repository structure validation passed$(NC)"

test: ## Run all tests
	@echo "$(BLUE)Running tests...$(NC)"
	$(PYTHON) -m pytest $(TEST_DIR) -v --cov=$(SRC_DIR) --cov-report=html --cov-report=term
	@echo "$(GREEN)✅ Tests completed$(NC)"

lint: ## Run code linting and formatting
	@echo "$(BLUE)Running code linting...$(NC)"
	@echo "$(YELLOW)Checking Python code formatting...$(NC)"
	black --check $(SRC_DIR)/python/
	@echo "$(YELLOW)Checking import sorting...$(NC)"
	isort --check-only $(SRC_DIR)/python/
	@echo "$(YELLOW)Running flake8 linting...$(NC)"
	flake8 $(SRC_DIR)/python/ --max-line-length=88 --extend-ignore=E203,W503
	@echo "$(YELLOW)Running mypy type checking...$(NC)"
	mypy $(SRC_DIR)/python/ --ignore-missing-imports
	@echo "$(GREEN)✅ Code linting completed$(NC)"

format: ## Format code automatically
	@echo "$(BLUE)Formatting code...$(NC)"
	black $(SRC_DIR)/python/
	isort $(SRC_DIR)/python/
	@echo "$(GREEN)✅ Code formatting completed$(NC)"

security: ## Run security scans
	@echo "$(BLUE)Running security scans...$(NC)"
	@echo "$(YELLOW)Running Bandit security scan...$(NC)"
	bandit -r $(SRC_DIR)/python/ -f txt
	@echo "$(YELLOW)Running Safety dependency check...$(NC)"
	safety check
	@echo "$(YELLOW)Checking for secrets...$(NC)"
	@if command -v trufflehog >/dev/null 2>&1; then \
		trufflehog filesystem . --only-verified; \
	else \
		echo "$(YELLOW)⚠️ TruffleHog not installed, skipping secrets scan$(NC)"; \
	fi
	@echo "$(GREEN)✅ Security scans completed$(NC)"

powershell-lint: ## Lint PowerShell scripts (requires PSScriptAnalyzer)
	@echo "$(BLUE)Linting PowerShell scripts...$(NC)"
	@if command -v pwsh >/dev/null 2>&1; then \
		pwsh -Command "Invoke-ScriptAnalyzer -Path '$(SRC_DIR)/powercli/' -Recurse -ReportSummary"; \
	else \
		echo "$(YELLOW)⚠️ PowerShell Core not installed, skipping PowerShell linting$(NC)"; \
	fi
	@echo "$(GREEN)✅ PowerShell linting completed$(NC)"

docs: ## Generate documentation
	@echo "$(BLUE)Generating documentation...$(NC)"
	@if [ -f "mkdocs.yml" ]; then \
		mkdocs build; \
		echo "$(GREEN)✅ MkDocs documentation generated$(NC)"; \
	else \
		echo "$(YELLOW)⚠️ mkdocs.yml not found, skipping documentation generation$(NC)"; \
	fi

docs-serve: ## Serve documentation locally
	@echo "$(BLUE)Starting documentation server...$(NC)"
	@if [ -f "mkdocs.yml" ]; then \
		mkdocs serve; \
	else \
		echo "$(RED)❌ mkdocs.yml not found$(NC)"; \
		exit 1; \
	fi

clean: ## Clean up temporary files and caches
	@echo "$(BLUE)Cleaning up...$(NC)"
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	find . -type f -name ".coverage" -delete
	find . -type d -name "htmlcov" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
	rm -rf build/ dist/ site/
	@echo "$(GREEN)✅ Cleanup completed$(NC)"

check-links: ## Check for broken links in documentation
	@echo "$(BLUE)Checking documentation links...$(NC)"
	@if command -v markdown-link-check >/dev/null 2>&1; then \
		find . -name "*.md" -exec markdown-link-check {} \; ; \
	else \
		echo "$(YELLOW)⚠️ markdown-link-check not installed$(NC)"; \
		echo "Install with: npm install -g markdown-link-check"; \
	fi
	@echo "$(GREEN)✅ Link checking completed$(NC)"

yaml-lint: ## Lint YAML files
	@echo "$(BLUE)Linting YAML files...$(NC)"
	@if command -v yamllint >/dev/null 2>&1; then \
		yamllint .github/workflows/ -c .yamllint.yml; \
	else \
		echo "$(YELLOW)⚠️ yamllint not installed$(NC)"; \
		echo "Install with: pip install yamllint"; \
	fi
	@echo "$(GREEN)✅ YAML linting completed$(NC)"

markdown-lint: ## Lint Markdown files
	@echo "$(BLUE)Linting Markdown files...$(NC)"
	@if command -v markdownlint >/dev/null 2>&1; then \
		markdownlint "**/*.md" --config .markdownlint.json; \
	else \
		echo "$(YELLOW)⚠️ markdownlint not installed$(NC)"; \
		echo "Install with: npm install -g markdownlint-cli"; \
	fi
	@echo "$(GREEN)✅ Markdown linting completed$(NC)"

all-checks: validate lint security powershell-lint yaml-lint markdown-lint check-links ## Run all quality checks
	@echo "$(GREEN)🎉 All quality checks completed successfully!$(NC)"

pre-commit: format lint security ## Run pre-commit checks
	@echo "$(GREEN)✅ Pre-commit checks completed$(NC)"

ci: validate test security lint ## Run CI pipeline locally
	@echo "$(GREEN)🚀 CI pipeline completed successfully!$(NC)"

deploy-prep: clean all-checks test ## Prepare for deployment
	@echo "$(BLUE)Preparing for deployment...$(NC)"
	@echo "$(GREEN)✅ Deployment preparation completed$(NC)"

vsphere-test: ## Test vSphere connectivity (requires environment variables)
	@echo "$(BLUE)Testing vSphere connectivity...$(NC)"
	@if [ -z "$$VCENTER_SERVER" ]; then \
		echo "$(RED)❌ VCENTER_SERVER environment variable not set$(NC)"; \
		exit 1; \
	fi
	@if [ -z "$$VCENTER_USERNAME" ]; then \
		echo "$(RED)❌ VCENTER_USERNAME environment variable not set$(NC)"; \
		exit 1; \
	fi
	@if [ -z "$$VCENTER_PASSWORD" ]; then \
		echo "$(RED)❌ VCENTER_PASSWORD environment variable not set$(NC)"; \
		exit 1; \
	fi
	$(PYTHON) -c "from $(SRC_DIR).python.vsphere_api_examples import vSphereManager; \
		vsphere = vSphereManager('$$VCENTER_SERVER', '$$VCENTER_USERNAME', '$$VCENTER_PASSWORD'); \
		print('✅ vSphere connection test passed' if vsphere.connect() else '❌ vSphere connection failed'); \
		vsphere.disconnect()"

powercli-test: ## Test PowerCLI availability
	@echo "$(BLUE)Testing PowerCLI availability...$(NC)"
	@if command -v pwsh >/dev/null 2>&1; then \
		pwsh -Command "if (Get-Module -ListAvailable VMware.PowerCLI) { Write-Output '✅ PowerCLI module available' } else { Write-Output '❌ PowerCLI module not found' }"; \
	else \
		echo "$(RED)❌ PowerShell Core not installed$(NC)"; \
	fi

environment-check: ## Check development environment
	@echo "$(BLUE)Checking development environment...$(NC)"
	@echo "$(YELLOW)Python version:$(NC)"
	$(PYTHON) --version
	@echo "$(YELLOW)Pip version:$(NC)"
	$(PIP) --version
	@echo "$(YELLOW)Git version:$(NC)"
	git --version
	@if command -v docker >/dev/null 2>&1; then \
		echo "$(YELLOW)Docker version:$(NC)"; \
		docker --version; \
	else \
		echo "$(YELLOW)⚠️ Docker not installed$(NC)"; \
	fi
	@echo "$(GREEN)✅ Environment check completed$(NC)"

install-tools: ## Install additional development tools
	@echo "$(BLUE)Installing additional development tools...$(NC)"
	@echo "$(YELLOW)Installing Node.js tools...$(NC)"
	@if command -v npm >/dev/null 2>&1; then \
		npm install -g markdownlint-cli markdown-link-check; \
	else \
		echo "$(YELLOW)⚠️ npm not available, skipping Node.js tools$(NC)"; \
	fi
	@echo "$(YELLOW)Installing Python tools...$(NC)"
	$(PIP) install yamllint pre-commit
	@echo "$(GREEN)✅ Additional tools installed$(NC)"

update-deps: ## Update all dependencies
	@echo "$(BLUE)Updating dependencies...$(NC)"
	$(PIP) install --upgrade pip
	$(PIP) install --upgrade -r $(REQUIREMENTS)
	@echo "$(GREEN)✅ Dependencies updated$(NC)"

generate-report: ## Generate comprehensive project report
	@echo "$(BLUE)Generating project report...$(NC)"
	@echo "# VMware vSphere 7 Learning Hub - Project Report" > PROJECT_REPORT.md
	@echo "Generated on: $$(date)" >> PROJECT_REPORT.md
	@echo "" >> PROJECT_REPORT.md
	@echo "## Repository Statistics" >> PROJECT_REPORT.md
	@echo "- Total files: $$(find . -type f | wc -l)" >> PROJECT_REPORT.md
	@echo "- Python files: $$(find . -name '*.py' | wc -l)" >> PROJECT_REPORT.md
	@echo "- PowerShell files: $$(find . -name '*.ps1' | wc -l)" >> PROJECT_REPORT.md
	@echo "- Markdown files: $$(find . -name '*.md' | wc -l)" >> PROJECT_REPORT.md
	@echo "- YAML files: $$(find . -name '*.yml' -o -name '*.yaml' | wc -l)" >> PROJECT_REPORT.md
	@echo "" >> PROJECT_REPORT.md
	@echo "## Code Quality Metrics" >> PROJECT_REPORT.md
	@if command -v cloc >/dev/null 2>&1; then \
		echo "### Lines of Code" >> PROJECT_REPORT.md; \
		cloc --md $(SRC_DIR) >> PROJECT_REPORT.md; \
	fi
	@echo "$(GREEN)✅ Project report generated: PROJECT_REPORT.md$(NC)"

backup: ## Create backup of important files
	@echo "$(BLUE)Creating backup...$(NC)"
	@mkdir -p backups
	@tar -czf backups/vsphere-learning-backup-$$(date +%Y%m%d_%H%M%S).tar.gz \
		--exclude='backups' \
		--exclude='venv' \
		--exclude='__pycache__' \
		--exclude='.git' \
		--exclude='node_modules' \
		.
	@echo "$(GREEN)✅ Backup created in backups/ directory$(NC)"

# Development workflow shortcuts
dev: setup-dev environment-check ## Setup complete development environment
	@echo "$(GREEN)🎉 Development environment ready!$(NC)"

quick-check: validate lint ## Quick validation and linting
	@echo "$(GREEN)✅ Quick checks completed$(NC)"

full-check: all-checks test ## Complete quality assurance check
	@echo "$(GREEN)🎉 Full quality check completed!$(NC)"

release-prep: clean full-check generate-report ## Prepare for release
	@echo "$(GREEN)🚀 Release preparation completed!$(NC)"# Updated 20251109_123839
# Updated Sun Nov  9 12:52:45 CET 2025
# Updated Sun Nov  9 12:55:57 CET 2025
# File updated 1762692708
