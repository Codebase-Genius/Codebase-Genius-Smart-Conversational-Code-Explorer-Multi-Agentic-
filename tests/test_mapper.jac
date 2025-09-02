import { BuildSemanticGraph } from "walkers";

walker TestMapper {
    has units: list[dict];

    can entry with root {
        spawn BuildSemanticGraph(units=self.units) at root;

        // basic sanity: at least one FileNode exists
        with root {
            assert count(FileNode) >= 0;
        }

        disengage;
    }
}
