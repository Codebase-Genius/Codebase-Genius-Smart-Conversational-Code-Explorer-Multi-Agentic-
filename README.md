# Codebase Genius — Smart Conversational Code Explorer

Multi-agent codebase explorer in **Jac**. Clones a repo, parses Python files into a semantic graph, generates docs with MTLLM, diagrams via Mermaid, and exposes a chat/search interface.

## 🚀 Features

- **🔄 Multi-Agent Architecture**: Specialized AI agents collaborate to analyze code
- **📊 Smart Code Analysis**: AST parsing with semantic relationship mapping
- **🤖 Conversational Interface**: Chat with your codebase using natural language
- **📈 Visual Diagrams**: Auto-generated Mermaid and D3.js visualizations
- **📝 Intelligent Documentation**: LLM-powered markdown generation
- **🔍 Semantic Search**: Find functions, classes, and relationships instantly
- **🌐 GitHub Integration**: One-click repository cloning and analysis

## 🏗️ Architecture

Codebase Genius employs 8 specialized agents working in harmony:

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│ RepoClonerAgent │────│ CoordinatorAgent │────│ DiagramAgent    │
└─────────────────┘    │   (Supervisor)   │    └─────────────────┘
                       └──────────────────┘
┌─────────────────┐           │                 ┌─────────────────┐
│ CodeParserAgent │───────────┼─────────────────│ DocWriterAgent  │
└─────────────────┘           │                 └─────────────────┘
                              │
┌─────────────────┐           │                 ┌─────────────────┐
│SemanticMapper   │───────────┼─────────────────│Conversational   │
│Agent            │           │                 │Agent            │
└─────────────────┘           │                 └─────────────────┘
                              │
                    ┌─────────────────┐
                    │   SearchAgent   │
                    └─────────────────┘
```

### Agent Responsibilities

| Agent | Purpose | Key Features |
|-------|---------|--------------|
| **RepoClonerAgent** | Repository management | GitHub cloning, file structure preparation |
| **CodeParserAgent** | Code analysis | AST parsing, class/function extraction |
| **SemanticMapperAgent** | Relationship mapping | Builds knowledge graph of code relationships |
| **DocWriterAgent** | Documentation generation | LLM-powered markdown creation |
| **DiagramAgent** | Visualization | Mermaid/D3.js diagram generation |
| **ConversationalAgent** | User interaction | Multi-turn chat interface |
| **SearchAgent** | Code search | Semantic search across codebase |
| **CoordinatorAgent** | Orchestration | Manages agent workflows and coordination |

## 🛠️ Installation

### Prerequisites

- Python 3.12+ and jaclang=0.8.
- Git
- OpenAI API key (or compatible LLM)

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-org/codebase-genius.git
   cd codebase-genius
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Configure environment**
   ```bash
   
   cp .env.example .env
   # Edit .env with your API keys
   ```

4. **Initialize Jac runtime**
   ```bash
   jac serve main.jac
   ``


## 📊 Supported Languages

- ✅ **Python** - Full AST support with class/function extraction
- ✅ **Jac** - Native language support


### Team Roles

- **Member 1**: Codebase Analyzer & Mapper Lead
- **Member 2**: AI & Documentation System Lead  
- **Member 3**: UI, Visualization & Coordinator Lead
