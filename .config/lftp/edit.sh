#!/bin/bash

# 1. Capture arguments
REMOTE_FILE="$1"  # The file on the server (e.g., index.php)

# 2. Secure Temporary Directory
# We create a secure specific folder for this session to avoid collisions.
TMP_DIR=$(mktemp -d)
LOCAL_FILE="$TMP_DIR/$(basename "$REMOTE_FILE")"
CHECK_FILE="$LOCAL_FILE.check"

# 3. Cleanup Trap
# This function runs automatically when the script exits (even if you Ctrl+C).
cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

# 4. Request Download
# We tell LFTP to download the file to our temp location.
echo "get \"$REMOTE_FILE\" -o \"$LOCAL_FILE\""

# 5. Wait for Download
# We loop until the file actually appears on the disk.
# Timeout after 10 seconds to prevent hanging forever.
TIMEOUT=100
while [[ ! -f "$LOCAL_FILE" && $TIMEOUT -gt 0 ]]; do
    sleep 0.1
    ((TIMEOUT--))
done

if [[ ! -f "$LOCAL_FILE" ]]; then
    echo "shell echo 'Error: File download timed out.'"
    exit 1
fi

# Create the initial comparison file
cp "$LOCAL_FILE" "$CHECK_FILE"

# 6. Launch Editor
# We use standard backgrounding (&) instead of coproc for better compatibility.
# We explicitly launch a terminal to hold the editor.
# NOTE: Change 'x-terminal-emulator' to 'terminator' or 'gnome-terminal' if you prefer.
x-terminal-emulator -e $VISUAL "$LOCAL_FILE" &
EDITOR_PID=$!

# 7. The Watch Loop
# While the editor process (PID) is still running...
while kill -0 "$EDITOR_PID" 2> /dev/null; do
    
    # Check if the file has been modified (is newer than the check file)
    if [[ "$LOCAL_FILE" -nt "$CHECK_FILE" ]]; then
        # Update the check file
        cp "$LOCAL_FILE" "$CHECK_FILE"
        
        # Tell LFTP to upload the changes
        echo "shell echo 'Auto-uploading $REMOTE_FILE...'"
        echo "put \"$LOCAL_FILE\" -o \"$REMOTE_FILE\""
    fi
    
    sleep 1
done

# 8. Final Upload (Safety)
# One last check/upload after the editor closes.
echo "put \"$LOCAL_FILE\" -o \"$REMOTE_FILE\""
echo "shell echo 'Editing finished. Temp files cleaned.'"
