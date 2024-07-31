# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Required commands
REQUIRED_COMMANDS=("top" "df" "grep" "awk" "mail")

# Validate each command
for cmd in "${REQUIRED_COMMANDS[@]}"; do
  if ! command_exists "$cmd"; then
    echo "Error: $cmd is not installed or not in the PATH."
    exit 1
  fi
done

echo "All required commands are available."
