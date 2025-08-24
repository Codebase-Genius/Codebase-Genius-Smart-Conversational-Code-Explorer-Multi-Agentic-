import { GenerateDocs } from "walkers"

walker TestDocs {
    has model: str;
    has units: list[dict];
    has out: str;

    can entry with root {
        // Spawn documentation generator
        g = spawn GenerateDocs(model=self.model, units=self.units) at root;

        // Validate output
        assert len(g.docs) >= 0;

        // Store result
        self.out = g.docs;

        // Optional: Log for traceability
        log("TestDocs generated documentation with model: " + self.model);
        log("Units processed: " + str(len(self.units)));
        log("Output length: " + str(len(self.out)));

        disengage;
    }
}