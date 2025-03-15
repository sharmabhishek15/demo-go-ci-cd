FROM golang:1.20 AS builder
WORKDIR /app

# Copy the Go module files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the application files
COPY . .

# Build the Go application
RUN go build -o demo-go-ci-cd

# Create a minimal runtime image
FROM alpine:latest

# Set working directory inside runtime container
WORKDIR /root/

# Copy binary from builder
COPY --from=builder /app/demo-go-ci-cd .
COPY --from=builder /app/config/config.yaml ./config/config.yaml

# Expose application port (change if needed)
EXPOSE 8080

# Run the application
CMD ["./demo-go-ci-cd"]