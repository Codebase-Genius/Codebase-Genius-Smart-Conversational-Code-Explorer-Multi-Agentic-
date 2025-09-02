import from schemas { nodes, edges }
import from architypes { RepoClonerAgent, CodeParserAgent, SemanticMapperAgent, DocWriterAgent, DiagramAgent, ConversationalAgent, SearchAgent, CoordinatorAgent }
import from walkers { repo_cloner_walkers, parser_walkers, semantic_walkers, doc_writer, diagram_walkers, conversational_walkers, search_walkers, coordinator_walkers }

glob llm = Model(model_name="gemini/gemini-2.0-flash");

obj MyApp {
    has model: str = "gpt-4o-mini";
    has workdir: str;

    def run(url: str) -> dict {
        r = walker RunAll { url: url, model: self.model } on ::root;

        files = [f.path for f in nodes::FileNode.entries()];
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
