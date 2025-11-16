# Start from the official ollama image
FROM ollama/ollama

# This command runs *once* during the build
# 1. Start the server in the background
# 2. WAIT 5 SECONDS for it to boot up (THIS IS THE FIX)
# 3. Pull the base model
# 4. Create the Modelfile with the 16-thread limit
# 5. Create the new "custom-nomic" model from that file
RUN ollama serve & \
    sleep 5 && \
    ollama pull nomic-embed-text && \
    echo "FROM nomic-embed-text\nPARAMETER num_thread 16" > /root/Modelfile && \
    ollama create custom-nomic -f /root/Modelfile

# This is the *only* command that runs when your service starts
CMD ["serve"]
