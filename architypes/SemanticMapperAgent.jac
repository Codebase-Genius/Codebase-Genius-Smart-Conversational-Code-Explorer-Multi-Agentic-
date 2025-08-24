obj SemanticMapperAgent {
    has lang: str = "python";

    can build_graph(units: list[dict]) {
        // Creates nodes/edges based on parsed units
        for u in units {
            fnode = spawn FileNode(
                name=u["file"],
                path=u["file"],
                lang=self.lang
            ) at root;

            for c in u.get("classes", []) {
                cnode = spawn ClassNode(
                    name=c["name"],
                    qname=c.get("qname", c["name"])
                ) at fnode;

                fnode ++> contains --> cnode;

                for m in c.get("methods", []) {
                    mnode = spawn FunctionNode(
                        name=m["name"],
                        qname=m.get("qname", m["name"])
                    ) at cnode;

                    cnode ++> defines --> mnode;
                }
            }

            for fn in u.get("functions", []) {
                fun = spawn FunctionNode(
                    name=fn["name"],
                    qname=fn.get("qname", fn["name"])
                ) at fnode;

                fnode ++> defines --> fun;
            }

            for imp in u.get("imports", []) {
                inode = spawn ImportNode(
                    name=imp,
                    module=imp
                ) at fnode;

                fnode ++> imports --> inode;
            }
        }
    }
}
