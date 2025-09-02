obj DocWriterAgent {
    has model: str = "gpt-4o-mini";  // Default LLM model

    can write_docs(prompt: str, units: list[dict]) -> str {
        import { OpenAI } from "mtllm.llms";
        glob llm = OpenAI(model_name=self.model);

        // Optional: Log for traceability
        log("DocWriterAgent invoked with " + str(len(units)) + " code units.");

        // Generate documentation using LLM
        text: str = llm.complete(
            prompt=prompt,
            context={"units": units}
        );

        return text;
    }
}