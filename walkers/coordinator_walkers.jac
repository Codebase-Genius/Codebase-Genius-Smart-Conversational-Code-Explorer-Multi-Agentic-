walker RunAll {
    has url: str;
    has model: str = "gpt-4o-mini";

    has repo: str;
    has units: list[dict];
    has docs: str;

    can entry with root entry {
        // Spawn the coordinator agent with working directory and model
        coord = spawn CoordinatorAgent(workdir=os.getcwd(), model=self.model) at root;

        // Run the full pipeline on the given repo URL
        out = coord.run(self.url);

        // Validate and extract results
        if "repo" in out and "units" in out and "docs" in out {
            self.repo = out["repo"];
            self.units = out["units"];
            self.docs = out["docs"];
            log("RunAll completed successfully for: " + self.url);
        } else {
            report "CoordinatorAgent returned incomplete output.";
            log("RunAll failed to extract all expected fields.");
        }

        // Emit results for downstream use
        report {
            "repo": self.repo,
            "unit_count": len(self.units),
            "doc_length": len(self.docs),
            "model": self.model
        };

        disengage;
    }
}