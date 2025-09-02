obj ConversationalAgent {
    has model: str = "gpt-4o-mini";  // Default model
    has system_prompt: str = "You are a helpful codebase assistant.";  // Configurable persona

    can answer(question: str) -> str {
        import { OpenAI } from "mtllm.llms";
        glob llm = OpenAI(model_name=self.model);

        // Gather context from the graph
        ctx: dict = {};
        with root {
            files: list[dict] = [];
            for f in FileNode {
                files.append({
                    "path": f.path,
                    "content": f.content  // Assumes FileNode has 'content' attribute
                });
            }
            ctx["files"] = files;
        }

        // Log or report for traceability (optional)
        log("ConversationalAgent received question: " + question);
        log("Context includes " + str(len(ctx["files"])) + " files.");

        // Validate model name (optional)
        if self.model notin ["gpt-4o-mini", "gpt-4", "claude-3-opus"] {
            raise "Unsupported model: " + self.model;
        }

        // Generate response
        reply: str = llm.chat(
            messages=[
                {"role": "system", "content": self.system_prompt},
                {"role": "user",   "content": question},
            ],
            context=ctx
        );

        return reply;
    }
}