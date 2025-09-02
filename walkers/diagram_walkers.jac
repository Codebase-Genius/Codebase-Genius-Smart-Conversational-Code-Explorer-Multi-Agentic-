walker DiagramForFile {
    has file: str;
    has mermaid: str = "";

    can entry with root entry {
        // Spawn the diagram agent at the root node
        agent = spawn DiagramAgent() at root;

        // Generate Mermaid diagram from the file
        self.mermaid = agent.mermaid_for_file(self.file);

        // Optional: log for traceability
        log("DiagramForFile generated diagram for: " + self.file);
        log("Mermaid output length: " + str(len(self.mermaid)));

        // Emit the diagram for chaining or inspection
        report {
            "file": self.file,
            "mermaid": self.mermaid
        };

        disengage;
    }
}