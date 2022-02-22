#!/bin/bash

export $(cat .env | sed 's/#.*//g' | xargs)

set -e

ROOT_PATH=$PWD

function download_runner {
    if [ ! -d "$ROOT_PATH/runner" ]; then
        # Create runner home folder
        mkdir runner && cd runner

        # Create a folder
        mkdir actions-runner && cd actions-runner

        # Download the latest runner package
        curl -o actions-runner-linux-x64-2.287.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.287.1/actions-runner-linux-x64-2.287.1.tar.gz

        # Extract the installer
        tar xzf ./actions-runner-linux-x64-2.287.1.tar.gz && rm actions-runner-linux-x64-2.287.1.tar.gz

        printf "\n###       RUNNER DOWNLOADED!      ###\n"
    else
        printf "\n### RUNNER FOLDER ALREADY EXISTS! ###\n"
    fi
}

function initialize_runner {
    if [ ! -f "$ROOT_PATH/runner/actions-runner/.credentials" ]; then
        bash $ROOT_PATH/runner/actions-runner/config.sh --url $GIT_URL --token $GIT_TOKEN

        printf "\n###        RUNNER INITIALIZED!        ###\n"
    else
        printf "\n### RUNNER CREDENTIALS ALREADY EXIST! ###\n\n"
    fi
}

function deploy_project {
    cd $ROOT_PATH

    docker-compose build --no-cache && docker-compose up -d

    printf "\n###     PROJECT DEPLOYED SUCCESSFULLY!     ###\n"
}

download_runner && initialize_runner && deploy_project
