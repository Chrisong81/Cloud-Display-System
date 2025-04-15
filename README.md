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

## Run
```bash
pi@raspberrypi:~ $ crontab -e
Choose 1-3 [1]: 1
Insert the following code to launch the startup process:
@reboot /home/pi/Documents/play.sh
```
