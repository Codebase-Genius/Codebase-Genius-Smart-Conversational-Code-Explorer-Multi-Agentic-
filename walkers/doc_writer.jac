walker GenerateDocs {
    has model: str;
    has units: list[dict];
    has docs: str = "";

    can entry with root entry {
        # Spawn the documentation agent
        agent = spawn DocWriterAgent(model=self.model) at root;

        # Import prompt template from Python module
        import from py { prompts as P };
        prompt: str = P.doc_prompt();

        # Validate units before proceeding
        if len(self.units) == 0 {
            report "No code units provided. Skipping documentation generation.";
            disengage;
        }

        # Generate documentation using the prompt and code units
        self.docs = agent.write_docs(prompt, self.units);

        # Emit result for logging or chaining
        report {
            "model": self.model,
            "units_count": len(self.units),
            "docs_preview": self.docs[:200]  # first 200 chars for sanity check
        };

        disengage;
    }
}