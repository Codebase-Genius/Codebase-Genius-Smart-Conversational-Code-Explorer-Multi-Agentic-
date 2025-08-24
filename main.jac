import from mtllm { Model }
import schemas { nodes, edges }
import agents { RepoClonerAgent, CodeParserAgent, SemanticMapperAgent, DocWriterAgent, DiagramAgent, ConversationalAgent, SearchAgent, CoordinatorAgent }
import walkers { RunAll, SearchSymbols, AskCodebase, DiagramForFile }

glob llm = Model(model_name="gemini/gemini-2.0-flash");

obj App {
    has model: str = "gpt-4o-mini";
    has workdir: str = os.getcwd();

    can run(url: str) -> dict;
}

impl App.run(url: str) -> dict {
    // Launch the full multi-agent pipeline
    r = spawn RunAll(url=url, model=self.model) at root;

    // Extract file paths from semantic graph nodes
    files = [f.path for f in FileNode];

    // Return structured output
    return {
        "repo": r.repo,
        "docs": r.docs,
        "files": files
    };
}