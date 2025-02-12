# Start a new stage from scratch
FROM alpine:latest

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the pre-built binary and templates into the container
COPY mailerApp /app
COPY templates /app/templates

# Ensure the binary has execute permissions
RUN chmod +x /app/mailerApp

# Expose the port that your application will use
EXPOSE 80

# Command to run the executable when the container starts
CMD ["/app/mailerApp"]
