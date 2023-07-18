#!/bin/zsh

# github token
export GITHUB_TOKEN=$(opItem "GitHub Personal Access Token" token)

# dockerhub
export DOCKERHUB_USERNAME=""
export DOCKERHUB_PASSWSORD=""

export OPENAI_API_KEY=$(opItem "OpenAPI Key" token)
