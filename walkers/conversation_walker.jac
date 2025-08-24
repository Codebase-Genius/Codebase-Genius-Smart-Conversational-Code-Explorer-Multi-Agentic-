walker AskCodebase {
    has model: str;
    has question: str;
    has answer: str = "";

    can entry with root entry {
        // Spawn the conversational agent with the specified model
        agent = spawn ConversationalAgent(model=self.model) at root;

        // Ask the question and store the response
        self.answer = agent.answer(self.question);

        // Optional: log for traceability
        log("AskCodebase invoked with model: " + self.model);
        log("Question: " + self.question);
        log("Answer: " + self.answer);

        // Emit the answer for downstream use
        report {
            "model": self.model,
            "question": self.question,
            "answer": self.answer
        }

        // Clean exit
        disengage;
    }
}