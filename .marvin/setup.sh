#!/bin/bash

# MARVIN Setup Script
# Interactive setup for your personal AI Chief of Staff

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Print with color
print_color() {
    printf "${1}${2}${NC}\n"
}

print_header() {
    echo ""
    print_color "$CYAN" "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    print_color "$CYAN" "$1"
    print_color "$CYAN" "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Get the template directory (parent of .marvin where this script lives)
TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Default workspace location
DEFAULT_WORKSPACE="$HOME/start"

print_header "MARVIN Setup"
echo "Welcome! Let's set up your personal AI Chief of Staff."
echo "This will take about 5 minutes."
echo ""

# ============================================================================
# PHASE 1: Prerequisites
# ============================================================================

print_header "Phase 1: Prerequisites"

# Check for Homebrew (macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command_exists brew; then
        print_color "$YELLOW" "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH for Apple Silicon
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        print_color "$GREEN" "Homebrew installed!"
    else
        print_color "$GREEN" "Homebrew: installed"
    fi
fi

# Check for Copilot CLI
if ! command_exists copilot; then
    print_color "$YELLOW" "Copilot CLI not found. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install copilot-cli
    else
        # For Linux, use npm
        if command_exists npm; then
            npm i @github/copilot
        else
            print_color "$RED" "Please install Copilot CLI manually:"
            print_color "$RED" "  https://docs.github.com/en/copilot/how-tos/copilot-cli/set-up-copilot-cli/install-copilot-cli"
            exit 1
        fi
    fi
    print_color "$GREEN" "Copilot CLI installed!"
else
    print_color "$GREEN" "Copilot CLI: installed"
fi

# Check for git
if ! command_exists git; then
    print_color "$RED" "Git is required but not installed."
    print_color "$RED" "Please install git and run this script again."
    exit 1
else
    print_color "$GREEN" "Git: installed"
fi
