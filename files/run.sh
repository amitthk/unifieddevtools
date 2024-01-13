#!/bin/bash

# Function to start Theia by default
start_theia() {
    ./run-theia.sh
}

# Function to start the process based on the artifact type
start_process() {
    if [[ $S3_OBJECT == *.jar ]]; then
        ./run-java.sh &
    elif [[ $S3_OBJECT == *.py ]]; then
        ./run-python.sh &
    elif [[ $S3_OBJECT == *.js ]]; then
        ./run-nodejs.sh &
    else
        start_theia
    fi

    echo $! > process.pid
}

# Function to restart the process
restart_process() {
    if [ -f process.pid ]; then
        kill -9 $(cat process.pid)
        rm process.pid
        start_process
    else
        echo "No process ID found. Starting new process."
        start_process
    fi
}

# Check for command line argument
case "$1" in
    start)
        start_process
        ;;
    restart)
        restart_process
        ;;
    *)
        start_theia
        ;;
esac
