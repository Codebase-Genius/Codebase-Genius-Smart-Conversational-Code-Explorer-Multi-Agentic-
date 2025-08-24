walker RepoCloner {
    has url: str;
    has out: str;

    can entry with root entry {
        // Spawn the repo cloning agent with working directory
        agent = spawn RepoClonerAgent(workdir=os.getcwd()) at root;

        // Clone the repository and store the output path
        self.out = agent.clone_repo(self.url);

        // Optional: log for traceability
        log("RepoCloner invoked for URL: " + self.url);
        log("Repository cloned to: " + self.out);

        // Emit result for logging or chaining
        report {
            "url": self.url,
            "cloned_path": self.out
        };

        disengage;
    }
}