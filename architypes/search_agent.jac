obj SearchAgent {
    can find_symbols(q: str) -> list[str] {
        hits: list[str] = [];

        with root {
            for n in ClassNode where n.name.contains(q) {
                hits.append(n.qname);
            }
            for f in FunctionNode where f.name.contains(q) {
                hits.append(f.qname);
            }
        }

        // Optional: Log for traceability
        log("SearchAgent found " + str(len(hits)) + " matches for query: " + q);

        return hits;
    }
}