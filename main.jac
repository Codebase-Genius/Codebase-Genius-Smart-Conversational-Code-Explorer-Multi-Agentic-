import from schemas { nodes, edges }
import from architypes { RepoClonerAgent, CodeParserAgent, SemanticMapperAgent, DocWriterAgent, DiagramAgent, ConversationalAgent, SearchAgent, CoordinatorAgent }
import from walkers { repo_cloner_walkers, parser_walkers, semantic_walkers, doc_writer, diagram_walkers, conversational_walkers, search_walkers, coordinator_walkers }

glob llm = Model(model_name="gemini/gemini-2.0-flash");

obj MyApp {
    has model: str = "gpt-4o-mini";
    has workdir: str;

    def run(url: str) -> dict {
        r = repo_cloner_walkers::RunAll(url=url, model=model) on ::root;
        p = parser_walkers::ParseAll(model=model) on ::root;
        s = semantic_walkers::SemanticMap(model=model) on ::root;
        d = doc_writer::DocWrite(model=model) on ::root;
        dg = diagram_walkers::DiagramGen(model=model) on ::root;
        c = conversational_walkers::Converse(model=model) on ::root;
        sr = search_walkers::SearchAll(model=model) on ::root;
        co = coordinator_walkers::Coordinate(model=model) on ::root;
        
        files = [f.path for f in nodes::FileNode.entries()];

        return {
            "url": url,
            "model": model,
            "workdir": workdir,
            "repo": r.repo,
            "docs": d.docs,
            "files": files
        };
    }
}
