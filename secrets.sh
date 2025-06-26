#!/bin/zsh

# github token
export GITHUB_TOKEN=$(vault get "GitHub Personal Access Token")

# dockerhub
export DOCKERHUB_USERNAME="apollorion"
export DOCKERHUB_PASSWORD=$(vault get "DockerHub")

export OPENAI_API_KEY=$(vault get "OpenAPI Key")

export CLOUDFLARE_API_TOKEN=$(vault get "Cloudflare API Key")
