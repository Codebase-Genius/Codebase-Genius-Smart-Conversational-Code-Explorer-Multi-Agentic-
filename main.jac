import from mtllm { Model }
import from schemas { nodes, edges }
import from architypes { RepoClonerAgent, CodeParserAgent, SemanticMapperAgent, DocWriterAgent, DiagramAgent, ConversationalAgent, SearchAgent, CoordinatorAgent }
import from walkers { RunAll, SearchSymbols, AskCodebase, DiagramForFile }

glob llm = Model(model_name="gemini/gemini-2.0-flash");

obj MyApp {
    has model: str = "gpt-4o-mini";
    has workdir: str;

    can run(url: str) -> dict {
        r = spawn RunAll(url=url, model=self.model) at root;
        files = [f.path for f in nodes.FileNode.entries()];
        return {
            "url": url,
            "model": self.model,
            "workdir": self.workdir,
            "repo": r.repo,
            "docs": r.docs,
            "files": files
        };
    }
}
