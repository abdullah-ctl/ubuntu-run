#!/bin/bash

# Prompt for the user's email address
read -p "📝 Enter your email address for the SSH key: " email

# Generate the SSH key pair with the specified email as the comment
echo "🔑 Generating SSH key pair for $email..."
ssh-keygen -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa

# Check if SSH key generation was successful
if [ $? -eq 0 ]; then
    echo "🎉 SSH key generated successfully! 🎉"
    echo "📂 The SSH key has been saved to: ~/.ssh/id_rsa"

    # Copy the public key to the clipboard
    if command -v xclip &>/dev/null; then
        # If xclip is installed (for Linux systems)
        xclip -sel clip < ~/.ssh/id_rsa.pub
        echo "📋 Public key copied to clipboard using xclip. 🎉"
    elif command -v pbcopy &>/dev/null; then
        # If pbcopy is installed (for macOS)
        pbcopy < ~/.ssh/id_rsa.pub
        echo "📋 Public key copied to clipboard using pbcopy. 🎉"
    else
        echo "⚠️ Please manually copy the public key from: ~/.ssh/id_rsa.pub"
    fi
else
    echo "❌ Error generating SSH key. Please try again."
fi
