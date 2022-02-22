# github-runner-docker

GitHub Actions runner container unsing host's docker socket 

## How to install

### Requirements

#### Linux

- Docker
- Docker Compose

### Setting up local environment

- Copy `.env.dist` contents to `.env` and set your environment variables.
- Initialize application using: `bash initialize.bash`
- Afterwards, start application using: `docker-compose up -d` inside project root folder

## Configuration

### Environment variables

- `UBUNTU_VERSION` _(string)_ - version of ubuntu image used inside container
- `GIT_TOKEN` _(string)_ - token of GitHub actions runner
- `GIT_URL` _(string)_ - url of a GitHub repo for runner
