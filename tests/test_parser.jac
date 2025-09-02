import { ParseRepo } from "walkers";

walker TestParser {
    has repo_path: str;
    has ok: bool = false;

    can entry with root {
        p = spawn ParseRepo(repo_path=self.repo_path) at root;

        assert p.units != [];

        self.ok = true;

        disengage;
    }
}
