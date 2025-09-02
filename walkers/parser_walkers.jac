walker ParseRepo {
    has repo_path: str;
    has units: list[dict] = [];

    can entry with root entry {
        // Spawn the code parser agent with the repo path
        agent = spawn CodeParserAgent(repo_path=self.repo_path) at root;

        // Parse the repository and store the extracted units
        self.units = agent.parse_repo([self.repo_path]);

        // Optional: log for traceability
        log("ParseRepo invoked for: " + self.repo_path);
        log("Parsed unit count: " + str(len(self.units)));

        // Emit summary for chaining or inspection
        report {
            "repo_path": self.repo_path,
            "units_count": len(self.units),
            "sample_unit": len(self.units) > 0 ? self.units[0] : {}
        };

        disengage;
    }
}