#!/bin/bash

# Function to check if Python is installed
check_python() {
    if command -v python3 &>/dev/null; then
        # Python is installed
        echo "Python is already installed. Executing provided command..."
        exit 1
    else
        # Python is not installed
        echo "Python is not installed. Installing Python..."
        install_python
        if [ $? -eq 0 ]; then
            echo "Python installed successfully. Executing provided command..."
            exit 1
        else
            echo "Failed to install Python. Exiting."
            exit 0
        fi
    fi
}

install_python() {
    # Use appropriate package manager based on the system
    if [ -x "$(command -v apt)" ]; then
        sudo apt update
        sudo apt install -y python3
    elif [ -x "$(command -v yum)" ]; then
        sudo yum install -y python3
    elif [ -x "$(command -v brew)" ]; then
        echo "Please get Python3 installed with the help of Admin Team"
    else
        echo "Unsupported package manager. Please install Python manually."
        exit 1
    fi
}

check_python