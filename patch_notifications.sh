#!/bin/bash

# Path to the problematic file in the newer version
FILE_PATH="$HOME/.pub-cache/hosted/pub.dev/flutter_local_notifications-17.2.0/android/src/main/java/com/dexterous/flutterlocalnotifications/FlutterLocalNotificationsPlugin.java"

# Check if the file exists
if [ -f "$FILE_PATH" ]; then
    echo "Patching Flutter Local Notifications plugin..."
    
    # Create a backup
    cp "$FILE_PATH" "${FILE_PATH}.backup"
    
    # Replace the problematic line with a version that explicitly casts to Bitmap
    sed -i '' 's/bigPictureStyle.bigLargeIcon(null);/bigPictureStyle.bigLargeIcon((android.graphics.Bitmap) null);/' "$FILE_PATH"
    
    echo "Patch applied successfully!"
else
    echo "File not found: $FILE_PATH"
    echo "Please check the path or the plugin version."
fi