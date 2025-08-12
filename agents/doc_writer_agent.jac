architype DocWriterAgent {
    can generate_docs;
}

walker generate_docs {
    for node in graph {
        if node.type == "function" or node.type == "class" {
            prompt = "Summarize this " + node.type + ":\n" + node.code;
            summary = py_call("utils.llm_utils", "call_llm", prompt);
            node.summary = summary;
        }
    }
}
