node RepoNode {
    has url: str;
    has path: str;
}

node FileNode {
    has name: str;
    has path: str;
    has lang: str;
    has content: str;     // Optional: for LLM grounding
    has summary: str;     // Optional: for quick context
}

node ClassNode {
    has name: str;
    has qname: str;
    has docstring: str;   // Optional: for documentation
    has decorators: list[str];  // Optional: for semantic tagging
}

node FunctionNode {
    has name: str;
    has qname: str;
    has docstring: str;   // Optional: for documentation
    has decorators: list[str];  // Optional: for semantic tagging
    has scope: str;       // Optional: "global" or class name
}

node ImportNode {
    has name: str;
    has module: str;
    has type: str;        // Optional: "builtin", "external", "local"
}