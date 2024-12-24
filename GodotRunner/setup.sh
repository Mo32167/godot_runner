#!/bin/bash

# Set the path to the user's home directory
USER_HOME="$HOME"

# Set the target directory and source directory
TARGET_DIR="$USER_HOME/Apps/GodotRunner"
SOURCE_DIR="$(pwd)"  # Current directory where the script is being run

# Create the Apps directory if it doesn't exist
if [ ! -d "$USER_HOME/Apps" ]; then
    echo "Creating Apps directory at $USER_HOME/Apps"
    mkdir -p "$USER_HOME/Apps"
fi

# Check if GodotRunner exists in the target directory
if [ -d "$TARGET_DIR" ]; then
    echo "GodotRunner directory already exists. Updating contents..."
else
    # If GodotRunner doesn't exist, create the directory
    echo "GodotRunner directory doesn't exist. Creating new directory..."
    mkdir -p "$TARGET_DIR"
fi

# Copy all files from the source directory to the target directory, but avoid nesting
echo "Copying files from $SOURCE_DIR to $TARGET_DIR..."
# Only copy contents of the source directory, not the source directory itself
find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 -exec cp -rn {} "$TARGET_DIR/" \;

# Set the paths for the .desktop file and the icon
DESKTOP_FILE="$USER_HOME/.local/share/applications/GodotRunner.desktop"
ICON_PATH="$USER_HOME/Apps/GodotRunner/icon.svg"
EXEC_PATH="$USER_HOME/Apps/GodotRunner/run_godot"

# Generate the .desktop file
echo "Generating GodotRunner.desktop file..."
cat > "$DESKTOP_FILE" <<EOL
[Desktop Entry]
Name=GodotRunner
Comment=Run Godot from GodotRunner
Exec=$EXEC_PATH
Icon=$ICON_PATH
Terminal=true
Type=Application
Categories=Development;Game;
EOL

# Update the desktop application database
update-desktop-database ~/.local/share/applications/

echo "GodotRunner.desktop has been created and desktop database updated."

