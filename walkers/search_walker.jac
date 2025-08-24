walker SearchSymbols {
    has query: str;
    has results: list[str] = [];

    can entry with root entry {
        // Spawn the search agent
        agent = spawn SearchAgent() at root;

        // Perform symbol search using the query
        self.results = agent.find_symbols(self.query);

        // Optional: log for traceability
        log("SearchSymbols invoked with query: " + self.query);
        log("Matches found: " + str(len(self.results)));

        // Emit summary for logging or chaining
        report {
            "query": self.query,
            "results_count": len(self.results),
            "sample_result": len(self.results) > 0 ? self.results[0] : "No match"
        };

        disengage;
    }
}