# Base Go Image to build upon
FROM golang:1.18-alpine as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app
RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api

# Start a new stage from scratch
FROM alpine:latest

# Set the Current Working Directory inside the container
WORKDIR /app

# Create directory (optional, since COPY will create it)
RUN mkdir -p /app

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/brokerApp /app

# Ensure the binary has execute permissions
RUN chmod +x /app/brokerApp

# Expose port 80 to the outside world
EXPOSE 80

# Command to run the executable
CMD ["/app/brokerApp"]
