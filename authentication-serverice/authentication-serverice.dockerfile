# Start a new stage from scratch
FROM alpine:latest

# Set the Current Working Directory inside the container
WORKDIR /app

# Create directory (optional, since COPY will create it)
RUN mkdir -p /app

# Copy the Pre-built binary file from the previous stage
COPY authApp /app

# Ensure the binary has execute permissions
RUN chmod +x /app/authApp

# Expose port 80 to the outside world
EXPOSE 80

# Command to run the executable
CMD ["/app/authApp"]