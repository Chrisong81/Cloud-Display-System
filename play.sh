#!/bin/bash

# Path to the folder with media (videos + images)
MEDIA_DIR=~/Videos

# Path to MPV executable
MPV_BIN=/usr/bin/mpv

# Store MPV PID
MPV_PID_FILE=/tmp/mpv.pid

# Path to MPV IPC Socket (for controlling MPV)
MPV_SOCKET=/tmp/mpv_socket

# Function to start MPV with videos and images
start_mpv() {
  # Kill existing MPV process if running
  if [[ -f $MPV_PID_FILE ]]; then
    kill $(cat $MPV_PID_FILE) 2>/dev/null
    sleep 2  # Ensure MPV exits before restarting
    rm -f $MPV_PID_FILE
  fi

  # Start MPV with loop, fullscreen, and IPC socket
  DISPLAY=:0 $MPV_BIN --fullscreen --loop-playlist \
  --image-display-duration=15 --no-terminal --volume=50 \
  --audio-stream-silence=no \
  --log-file=/tmp/mpv.log \
  --input-ipc-server=$MPV_SOCKET \
  "$MEDIA_DIR"/*.{mp4,jpg,png} > /dev/null 2>&1 &

  echo $! > $MPV_PID_FILE
}

# Start MPV initially
start_mpv

# Function to get the current playlist files from MPV
get_playlist() {
  echo '{"command": ["get_property", "playlist"]}' | socat - $MPV_SOCKET | jq -r '.data[].filename' 2>/dev/null
}

# Function to update the playlist without duplicating files
refresh_playlist() {
  # Get the current playlist
  local current_playlist
  current_playlist=$(get_playlist)

  # Iterate through media files and add only if not already in playlist
  for file in "$MEDIA_DIR"/*.{mp4,jpg,png}; do
    [[ -e "$file" ]] || continue

    if ! grep -q "$file" <<< "$current_playlist"; then
      echo "{\"command\": [\"loadfile\", \"$file\", \"append\"]}" | socat - $MPV_SOCKET
      echo "Added to playlist: $file"
    fi
  done

  # Force audio playback to resume
  echo '{"command": ["set_property", "mute", "no"]}' | socat - $MPV_SOCKET

  echo "Playlist refreshed without duplicates."
}

# Monitor the folder for new or removed files
inotifywait -m -e create -e delete -e moved_to -e moved_from "$MEDIA_DIR" | while read -r directory events filename; do
  if [[ $filename == *.mp4 || $filename == *.jpg || $filename == *.png ]]; then
    echo "Detected change in $MEDIA_DIR. Refreshing MPV playlist..."
    refresh_playlist
  fi
done
