// This walker provides a basic search capability.
walker search_by_name with name: str {
    // Use a graph query to find nodes where the 'name' attribute matches.
    // The '-->' syntax means 'traverse outgoing edges from the current node'.
    // Here, we start from the graph root node implicitly.
    found_nodes = -->[node.name == name];

    if(found_nodes.length > 0) {
        // 'visit' sets the walker's context to the found node(s).
        visit found_nodes;
        // 'yield' returns the result to the caller.
        yield visitor;
    } else {
        yield null;
    }
}