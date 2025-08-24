from openai import OpenAI


class LLM:
    def __init__(self, api_key: str, model: str = "qwen/qwen-2.5-72b-instruct:free"):
        self.client = OpenAI(
            base_url="https://openrouter.ai/api/v1",
            api_key=api_key,
        )
        self.model = model

    def ask(self, prompt: str) -> str:
        """Send a prompt to the AI and return the response"""
        completion = self.client.chat.completions.create(
            model=self.model,
            messages=[
                {"role": "user", "content": prompt}
            ]
        )
        return completion.choices[0].message.content