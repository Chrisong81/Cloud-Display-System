# Cloud Display System (Raspberry Pi)

A cloud display system projects or renders data visually using cloud computing infrastructure, enabling real-time, scalable, and remote access to complex graphics or dashboards. It supports collaboration, dynamic updates, and seamless integration across devices and networks via the internet.

## 🚀 Features
- Displays both images and videos
- Remote Access
- Cloud Storage Integration
- Real-Time Updates

## 🛠️ Installation
### MPV
```bash
sudo apt install mpv
```

### Inotifywait
```bash
sudo apt install inotify-tools
```

### Rclone
```bash
sudo apt install rclone
```
### Run the configuration wizard:
```bash
rclone config
```
- Enter n (for a new connection) and then press enter
- Enter a name for the connection (i’ll enter dropbox) and press enter
- Enter 8 for “Dropbox” and press enter
- Press Enter for client ID
- Press Enter for client Secret
- Enter n for advanced config
- Enter y for “use auto config”

## Run
```bash
pi@raspberrypi:~ $ crontab -e
Choose 1-3 [1]: 1
Insert the following code to launch the startup process:
@reboot /home/pi/Documents/play.sh
```
