import os
import ast
import json
from typing import Dict, List, Union

IGNORES = {".git", "__pycache__", ".venv", ".mypy_cache"}


class Visitor(ast.NodeVisitor):
    def __init__(self, filename: str):
        self.filename = filename
        self.classes: List[dict] = []
        self.functions: List[dict] = []
        self.imports: List[str] = []

    def visit_Import(self, node: ast.Import) -> None:
        for n in node.names:
            self.imports.append(n.name)

    def visit_ImportFrom(self, node: ast.ImportFrom) -> None:
        mod = node.module or ""
        for n in node.names:
            self.imports.append(f"{mod}.{n.name}" if mod else n.name)

    def visit_FunctionDef(self, node: ast.FunctionDef) -> None:
        self.functions.append({
            "name": node.name,
            "qname": node.name,
            "docstring": ast.get_docstring(node),
            "decorators": [d.id for d in node.decorator_list if isinstance(d, ast.Name)]
        })

    def visit_ClassDef(self, node: ast.ClassDef) -> None:
        cls = {
            "name": node.name,
            "qname": node.name,
            "docstring": ast.get_docstring(node),
            "decorators": [d.id for d in node.decorator_list if isinstance(d, ast.Name)],
            "methods": []
        }
        for b in node.body:
            if isinstance(b, ast.FunctionDef):
                cls["methods"].append({
                    "name": b.name,
                    "qname": f"{node.name}.{b.name}",
                    "docstring": ast.get_docstring(b),
                    "decorators": [d.id for d in b.decorator_list if isinstance(d, ast.Name)]
                })
        self.classes.append(cls)


def parse_path(path: str) -> Union[Dict, List[Dict]]:
    """Parse a file or directory into a structured unit dict."""
    files: List[str] = []

    # Collect .py files
    if os.path.isdir(path):
        for root, dirs, fns in os.walk(path):
            dirs[:] = [d for d in dirs if d not in IGNORES]
            for fn in fns:
                if fn.endswith(".py"):
                    files.append(os.path.normpath(os.path.join(root, fn)))
    else:
        files = [path]

    out: List[dict] = []

    # Process each file
    for f in files:
        try:
            with open(f, "r", encoding="utf-8", errors="ignore") as fh:
                src = fh.read()
            tree = ast.parse(src)
            v = Visitor(f)
            v.visit(tree)
            out.append({
                "file": f,
                "classes": v.classes,
                "functions": v.functions,
                "imports": v.imports,
                "summary": f"{len(v.classes)} classes, {len(v.functions)} functions"
            })
        except Exception as e:
            out.append({
                "file": f,
                "error": str(e),
                "classes": [],
                "functions": [],
                "imports": [],
                "summary": "Parse failed"
            })

    return {"file": path, "units": out} if os.path.isdir(path) else out[0]