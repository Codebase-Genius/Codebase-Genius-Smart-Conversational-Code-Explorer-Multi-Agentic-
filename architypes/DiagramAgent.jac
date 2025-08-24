obj DiagramAgent {
    can mermaid_for_file(file: str) -> str {
        // Generate a Mermaid class diagram snippet from the graph
        mer: str = "classDiagram\n";

        with root {
            for f in FileNode where f.path == file {
                for c in f -[contains]-> ClassNode {
                    mer += f"class {c.name}\n";
                    for m in c -[defines]-> FunctionNode {
                        mer += f"{c.name} : {m.name}()\n";
                    }
                }
            }
        }

        return mer;
    }
}