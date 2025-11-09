#!/usr/bin/env python3
"""Basic tests for vSphere learning repository."""

import os
import sys
import unittest
from pathlib import Path

# Add scripts directory to path
sys.path.insert(0, str(Path(__file__).parent.parent / "scripts" / "python"))


class TestBasicFunctionality(unittest.TestCase):
    """Basic functionality tests."""

    def test_repository_structure(self):
        """Test repository has required structure."""
        repo_root = Path(__file__).parent.parent
        
        required_dirs = ["scripts", "docs", "examples", "labs", "tests", ".github"]
        for dir_name in required_dirs:
            self.assertTrue((repo_root / dir_name).exists(), f"Missing directory: {dir_name}")

    def test_required_files(self):
        """Test required files exist."""
        repo_root = Path(__file__).parent.parent
        
        required_files = ["README.md", "LICENSE", "requirements.txt", "package.json"]
        for file_name in required_files:
            self.assertTrue((repo_root / file_name).exists(), f"Missing file: {file_name}")

    def test_python_script_syntax(self):
        """Test Python scripts have valid syntax."""
        scripts_dir = Path(__file__).parent.parent / "scripts" / "python"
        
        for py_file in scripts_dir.glob("*.py"):
            with open(py_file, 'r', encoding='utf-8') as f:
                try:
                    compile(f.read(), py_file, 'exec')
                except SyntaxError as e:
                    self.fail(f"Syntax error in {py_file}: {e}")


if __name__ == '__main__':
    unittest.main()# Updated 20251109_123839
# Updated Sun Nov  9 12:49:15 CET 2025
