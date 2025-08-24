Multi-agent codebase explorer in **Jac**. Clones a repo, parses Python files into a semantic graph, generates docs with MTLLM, diagrams via Mermaid, and exposes a chat/search interface.

## Quickstart
```bash
python -m pip install -U pip
pip install -r requirements.txt
jac run main.jac
````

### Run the whole pipeline

In `main.jac`, the `App.run(url)` spawns the `RunAll` walker. You can try from the Jac REPL:

```jac
spawn App().run("https://github.com/pallets/flask");
```

### Project Layout

* `schemas/` — Nodes & edges for the object-spatial graph
* `agents/` — Service objects (cloner, parser, mapper, docs, diagrams, chat, search, coordinator)
* `walkers/` — Orchestration walkers
* `utils/` — Python helpers (AST parse, Git clone, prompts)
* `prompts/` — LLM prompt templates
* `tests/` — Minimal Jac-based tests

## Notes

* Requires Python 3.12+ and `jaclang>=0.8`.
* MTLLM will use your provider creds (e.g., OpenAI). Configure your env as needed.
* The AST parser currently supports Python; extend `SemanticMapperAgent` for other languages.
