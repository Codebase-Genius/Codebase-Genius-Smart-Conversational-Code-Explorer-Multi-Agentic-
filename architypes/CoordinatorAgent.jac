obj CoordinatorAgent {
    has workdir: str;
    has model: str = "gpt-4o-mini";

    can run(url: str) -> dict {
        // 1) Clone repository
        rc = spawn RepoClonerAgent(workdir=self.workdir) at root;
        repo_path: str = rc.clone_repo(url);

        // 2) Parse source code
        cp = spawn CodeParserAgent(repo_path=repo_path) at root;
        units: list[dict] = cp.parse_repo([repo_path]);

        // 3) Build semantic graph
        sm = spawn SemanticMapperAgent(lang="python") at root;
        sm.build_graph(units);

        // 4) Generate documentation
        import { prompts as P } from "py";  // Shim from utils/llm_interface.py
        prompt: str = P.doc_prompt();
        dw = spawn DocWriterAgent(model=self.model) at root;
        docs: str = dw.write_docs(prompt, units);

        // Optional: Log or report for traceability
        log("CoordinatorAgent completed run for: " + url);
        log("Parsed units: " + str(len(units)));
        log("Documentation length: " + str(len(docs)));

        return {
            "repo": repo_path,
            "units": units,
            "docs": docs
        };
    }
}