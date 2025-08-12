// This walker handles a user's natural language query.
import:py from "utils/llm_utils.py";
import:jac search_graph from "walkers/search_graph.jac";

walker handle_query with query: str, entity_name: str {
    // Step 1: Find the relevant node in the graph using our search walker.
    // We 'spawn' a temporary search walker to do the job.
    node_found = spawn here walker::search_by_name(name=entity_name);

    if(node_found) {
        // Step 2: Build the context for the LLM.
        context = f"Code for '{node_found.name}':\n{node_found.code}\n\n";
        context += f"Documentation/Summary:\n{node_found.summary}";

        // Step 3: Load the prompt template and format it.
        followup_prompt_template = file.load_str("prompts/followup_template.txt");
        final_prompt = followup_prompt_template.format(context=context, question=query);

        // Step 4: Call the LLM to get an answer.
        answer = -[llm_utils.call_llm](prompt=final_prompt);
        std.out(f"Answer: {answer}");
        yield answer;

    } else {
        response = f"Sorry, I could not find anything named '{entity_name}' in the codebase.";
        std.out(response);
        yield response;
    }
}