// This walker traverses the graph, finds code nodes without documentation,
// and uses the LLM to generate it.

// We need to import the python utility module to use its functions.
// The -[...]() syntax is how Jac calls external Python code.
import:py from "utils/llm_utils.py";

walker generate_docs {
    // Traverse every node in the graph
    for node in graph {
        // We only want to document functions that don't already have a summary.
        // This check prevents us from re-doing work or overwriting existing docs.
        if (node.type == "function" and !node.summary) {
            std.out(f"Generating docs for function: {node.name}...");

            // Load the prompt template from the file
            doc_prompt_template = file.load_str("prompts/doc_template.txt");

            // Format the prompt with the actual code from the node
            final_prompt = doc_prompt_template.format(code=node.code);

            // Call the external Python function to query the LLM
            // The result is stored in the 'summary' variable
            summary = -[llm_utils.call_llm](prompt=final_prompt);

            // Attach the generated summary as an attribute to the node
            node.summary = summary;
        }
    }
    std.out("Documentation generation complete.");
}