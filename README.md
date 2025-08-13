# Codebase-Genius-Smart-Conversational-Code-Explorer-Multi-Agentic-

# Codebase Genius 🧠✨

Codebase Genius is an AI-powered system that allows users to explore and understand complex codebases through a smart, conversational interface. It uses a team of intelligent agents that collaborate to parse code, extract key structures, generate documentation, visualize relationships, and answer natural language questions.

## 🚀 Key Features

-   **Clone & Analyze:** Ingests and analyzes code from any public GitHub repository.
-   **AST Parsing:** Parses code files into Abstract Syntax Trees (ASTs) to extract classes, functions, and imports.
-   **Semantic Graph:** Builds a knowledge graph to map relationships (e.g., function calls, inheritance) between code entities.
-   **AI-Powered Documentation:** Uses Large Language Models (LLMs) like GPT-4 to generate clear, human-readable documentation for functions and classes.
-   **Code Visualization:** Renders Mermaid.js diagrams of the codebase structure.
-   **Conversational Q&A:** Provides a chat interface to ask multi-turn, natural language questions about the code.

## 🏛️ Architecture Overview

The system is built on the Jaseci framework using a multi-agent architecture. Each agent is a specialized worker with a distinct role, coordinated by a central `CoordinatorAgent`. They communicate and share state through a shared graph database.

| Agent Name            | Purpose                                                       |
| --------------------- | ------------------------------------------------------------- |
| **RepoClonerAgent**   | Clones a GitHub repo and prepares the file structure.         |
| **CodeParserAgent**   | Parses code files into an AST, extracting key entities.       |
| **SemanticMapperAgent** | Builds the semantic graph by creating nodes and edges.      |
| **DocWriterAgent**    | Generates documentation for code nodes using an LLM.          |
| **SearchAgent**       | Performs semantic search on the knowledge graph.              |
| **DiagramAgent**      | Renders code structure into Mermaid.js diagrams.              |
| **ConversationalAgent** | Manages user interactions, maintains context, and routes queries. |
| **CoordinatorAgent**  | The central orchestrator that manages the entire pipeline.      |


## ⚙️ Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

### Prerequisites

-   Python 3.8+
-   An [OpenAI API Key](https://platform.openai.com/account/api-keys)

### Installation

1.  **Clone the repository:**
    ```bash
    git clone <your-repo-url>
    cd codebase-genius
    ```

2.  **Create and activate a virtual environment:**
    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows, use `venv\Scripts\activate`
    ```

3.  **Install the required packages:**
    ```bash
    pip install -r requirements.txt
    ```

4.  **Set up your environment variables:**
    Create a file named `.env` in the root directory and add your OpenAI API key:
    ```
    OPENAI_API_KEY="sk-..."
    ```
    The `llm_utils.py` file is configured to automatically load this key.

## ▶️ How to Run

You can interact with the system using the Jaseci command-line tool, `jsctl`.

1.  **Start the Jaseci shell:**
    ```bash
    jsctl
    ```

2.  **Register the main Jac program:**
    (This loads all your agents and walkers into memory)
    ```jsctl
    jsctl> sentinel register main.jac
    ```

3.  **Initialize the agents:**
    Run the `init` walker to create instances of your agents on a new graph.
    ```jsctl
    jsctl> walker run init
    ```
    *You should see the output: "All agents have been spawned and are ready."*

4.  **Run the Documentation Agent:**
    (This will use a mock graph for now. It will be replaced by Member 1's output.)
    First, manually add a node to the graph to simulate a parsed function.
    ```jsctl
    jsctl> graph node set "urn:uuid:1" { "name": "hello_world", "type": "function", "code": "def hello_world():\n    print('Hello, World!')" }
    ```
    Now, run the `generate_docs` walker.
    ```jsctl
    jsctl> walker run generate_docs
    ```
    *This will call the OpenAI API, generate a summary, and attach it to the node.*

5.  **Run the Conversational Agent:**
    Ask a question about the function you just documented.
    ```jsctl
    jsctl> walker run handle_query -ctx '{"query": "What does the hello_world function do?", "entity_name": "hello_world"}'
    ```
    *You will see the AI-generated answer in the console.*

## 🧑‍💻 Team Roles & Responsibilities


-   **Dona (Codebase Analyzer & Mapper Lead):** Responsible for `RepoClonerAgent`, `CodeParserAgent`, and `SemanticMapperAgent`. Focuses on getting code from GitHub into the Jac graph.
-   **Mathusayini (AI & Documentation System Lead):** Responsible for `DocWriterAgent`, `ConversationalAgent`, and `SearchAgent`. Focuses on LLM integration and Q&A logic.
-   **Pingalan (UI, Visualization & Coordinator Lead):** Responsible for `CoordinatorAgent` and `DiagramAgent`. Focuses on orchestrating the workflow and handling visual output.
