walker BuildSemanticGraph {
    has units: list[dict];

    can entry with root entry {
        // Spawn the semantic mapper agent with language context
        agent = spawn SemanticMapperAgent(lang="python") at root;

        // Validate input units (optional)
        assert len(self.units) > 0, "No code units provided for graph construction.";

        // Build the semantic graph from parsed code units
        agent.build_graph(self.units);

        // Emit summary for logging or chaining
        report {
            "units_count": len(self.units),
            "graph_status": "Graph construction triggered",
            "sample_unit": self.units[0].keys() if len(self.units) > 0 else "N/A"
        };

        disengage;
    }
}