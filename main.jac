// Import all the agent archetypes you've created.
import:jac doc_writer_agent from "agents/doc_writer_agent.jac";
import:jac search_agent from "agents/search_agent.jac";
import:jac conversational_agent from "agents/conversational_agent.jac";

// Import the walkers that the agents will use.
import:jac generate_docs from "walkers/generate_docs.jac";
import:jac search_graph from "walkers/search_graph.jac";
import:jac handle_query from "walkers/handle_query.jac";

// The 'init' walker is a special walker that runs when the graph is initialized.
// It's the perfect place to set up our agents.
walker init {
    // 'spawn' creates an instance of an agent.
    // We spawn one of each type and anchor them to the root node of the graph.
    spawn here walker::DocWriterAgent;
    spawn here walker::SearchAgent;
    spawn here walker::ConversationalAgent;

    std.out("All agents have been spawned and are ready.");
}