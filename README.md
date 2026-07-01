# 🚀 Hadoop Auto Installer

A modular Bash-based automation toolkit for installing and configuring a **Single Node Apache Hadoop 3.4.1 Cluster** on Linux.

This project automates the complete Hadoop setup process, including Java installation, SSH configuration, Hadoop configuration, HDFS formatting, cluster startup, and a built-in MapReduce WordCount test.

---

## ✨ Features

- ✅ Automatic Java 11 detection and installation
- ✅ Passwordless SSH configuration
- ✅ Automatic Hadoop installation
- ✅ Environment variable configuration
- ✅ HDFS configuration
- ✅ YARN configuration
- ✅ NameNode formatting
- ✅ Start HDFS & YARN services
- ✅ Verify Hadoop cluster
- ✅ Automatic WordCount test
- ✅ Modular project architecture
- ✅ Colored terminal output
- ✅ Logging support
- ✅ Progress bar support

---

# 📂 Project Structure

```
Hadoop-Auto-Installer/
│
├── install_hadoop.sh
├── start_hadoop.sh
├── stop_hadoop.sh
├── restart_hadoop.sh
├── status_hadoop.sh
├── backup_hadoop.sh
├── restore_hadoop.sh
├── uninstall_hadoop.sh
│
├── lib/
│   ├── colors.sh
│   ├── logger.sh
│   ├── progress.sh
│   ├── common.sh
│   ├── java.sh
│   ├── ssh.sh
│   ├── config.sh
│   ├── hadoop.sh
│   └── test.sh
│
├── config/
│   ├── core-site.xml
│   ├── hdfs-site.xml
│   ├── mapred-site.xml
│   └── yarn-site.xml
│
├── logs/
├── backups/
├── screenshots/
│
├── README.md
├── LICENSE
├── CHANGELOG.md
└── .gitignore
```

---

# 🖥️ Supported Operating Systems

- Ubuntu 22.04+
- Ubuntu 24.04+
- Linux Mint 22+
- Debian-based Linux distributions

---

# 📦 Requirements

- Java 11
- SSH
- Internet connection
- Bash
- sudo privileges

---

# ⚙️ Installation

Clone the repository:

```bash
git clone https://github.com/Satya481/hadoop-auto-installer.git

cd hadoop-auto-installer
```

Make the installer executable:

```bash
chmod +x install_hadoop.sh
```

Run the installer:

```bash
./install_hadoop.sh
```

---

# ▶️ Management Scripts

Start Hadoop

```bash
./start_hadoop.sh
```

Stop Hadoop

```bash
./stop_hadoop.sh
```

Restart Hadoop

```bash
./restart_hadoop.sh
```

Check Status

```bash
./status_hadoop.sh
```

Backup

```bash
./backup_hadoop.sh
```

Restore

```bash
./restore_hadoop.sh
```

Uninstall

```bash
./uninstall_hadoop.sh
```

---

# 🧪 Testing

The installer automatically runs a Hadoop WordCount example after installation.

Expected output:

```
Hello    2
Hadoop   2
World    1
```

---

# 🌐 Hadoop Web Interfaces

HDFS NameNode

```
http://localhost:9870
```

YARN Resource Manager

```
http://localhost:8088
```

---

# 📋 Current Features

- Java installation
- SSH setup
- Hadoop installation
- Automatic configuration
- HDFS formatting
- Cluster verification
- WordCount testing
- Modular architecture
- Logging
- Progress bar

---

# 🚀 Roadmap

- [x] Modular architecture
- [x] Logging
- [x] Progress bar
- [x] Hadoop installation
- [x] Hadoop configuration
- [x] WordCount testing
- [ ] Backup & restore improvements
- [ ] Interactive menu
- [ ] Multi-version Hadoop support
- [ ] Multi-node cluster support

---

# 🤝 Contributing

Contributions are welcome.

1. Fork the repository
2. Create a new branch
3. Commit your changes
4. Open a Pull Request

---

# 📜 License

This project is licensed under the MIT License.

---

# 👨‍💻 Author

**Satyaprakash Gupta**

GitHub: https://github.com/Satya481

---

⭐ If you found this project useful, consider giving it a star on GitHub.
