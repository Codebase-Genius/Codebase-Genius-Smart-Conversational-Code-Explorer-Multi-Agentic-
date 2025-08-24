architype CodeParserAgent {
    has repo_path: str;

    can parse_repo(paths: list[str]) -> list[dict] {
        import { utils.ast_parser as ap } from py;
        results: list[dict] = [];

        if len(paths) == 0 {
            paths = [repo_path];
        }

        for p in paths {
            try {
                ast_data = ap.parse_path(p);
                results.append({
                    "path": p,
                    "ast": ast_data,
                    "status": "parsed"
                });
            } catch err {
                results.append({
                    "path": p,
                    "error": str(err),
                    "status": "failed"
                });
            }
        }

        return results;
    }
}