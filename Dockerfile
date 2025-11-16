# Start from the official ollama image
FROM ollama/ollama

# This command runs *once* during the build
# It starts the server, pulls the model, bakes the 16-thread
# limit into a new model, and then stops.
RUN ollama serve & \
    ollama pull nomic-embed-text && \
    echo "FROM nomic-embed-text\nPARAMETER num_thread 16" > /root/Modelfile && \
    ollama create custom-nomic -f /root/Modelfile

# This is the *only* command that runs when your service starts
CMD ["ollama", "serve"]
