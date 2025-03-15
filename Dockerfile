FROM golang:1.21 AS builder
WORKDIR /app

# Copy the Go module files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the application files
COPY . .

# # Set the working directory for the build
# WORKDIR /app/cmd/server

# Build the binary for Linux OS
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /app/demo-go-ci-cd cmd/server/main.go && ls -l /app/demo-go-ci-cd

# Create a minimal runtime image
FROM alpine:latest

# Set working directory inside runtime container
WORKDIR /root/

# Copy binary from builder
COPY --from=builder /app/demo-go-ci-cd .
COPY --from=builder /app/config ./config

# Ensure the binary has execution permissions
RUN chmod +x /root/demo-go-ci-cd

# Expose application port (change if needed)
EXPOSE 8080

# Run the application
CMD ["/root/demo-go-ci-cd"]