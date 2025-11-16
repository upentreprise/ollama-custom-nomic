# Start from the official ollama image
FROM ollama/ollama

# Add a small entrypoint script and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use the entrypoint to ensure the model exists at container startup
ENTRYPOINT ["/entrypoint.sh"]
CMD ["serve"]
