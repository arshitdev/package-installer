# Package Installer

A Bash script that bootstraps a Linux development machine with common development tools, utilities, Docker, and Visual Studio Code.

It detects the available package manager and supports APT (Debian/Ubuntu), DNF (Fedora/RHEL-family), and Pacman (Arch Linux).

## What it installs

The exact package names vary by distribution, but the script installs:

- Development tools: compiler toolchain, CMake, Git, and GDB
- Languages and runtimes: Python 3, pip, Python virtual environments where available, Java 17, Node.js, and npm
- Developer tools: Docker, tmux, Zsh, and Visual Studio Code
- Everyday utilities: `htop`, `net-tools`, `zip`, `unzip`, OpenSSH client tools, and `speedtest-cli`

Visual Studio Code is skipped when the `code` command is already available. On APT and DNF systems, the script adds Microsoft's official VS Code repository before installing it; on Arch, it installs the distribution package.

## Requirements

- A supported Linux distribution with `apt-get`, `dnf`, or `pacman`
- An internet connection
- A user account with `sudo` access

> [!WARNING]
> This script updates package metadata and installs system-wide packages. Review [`setup.sh`](setup.sh) before running it, especially on a machine with an existing development setup.

## Usage

Run the installer directly with `curl`:

```bash
curl -fsSL https://raw.githubusercontent.com/arshitdev/package-installer/main/setup.sh | bash
```

Or clone the repository and run the script locally:

```bash
git clone https://github.com/arshitdev/package-installer.git
cd package-installer
bash setup.sh
```

The script will prompt for your `sudo` password if required. Once it finishes, restart your terminal so newly installed commands and shell-related changes are available.

## Supported package managers

| Package manager | Typical distributions | Notes |
| --- | --- | --- |
| APT | Debian, Ubuntu, Linux Mint | Installs `build-essential`, `docker.io`, and VS Code from Microsoft's APT repository. |
| DNF | Fedora, RHEL-based distributions | Installs the `development-tools` group and VS Code from Microsoft's RPM repository. |
| Pacman | Arch Linux, Manjaro | Installs `base-devel` and the `code` package. |

If none of these package managers is found, the script exits without making changes.

## Troubleshooting

- **`Permission denied`**: run it with `bash setup.sh`, as shown above, or make it executable with `chmod +x setup.sh` and use `./setup.sh`.
- **Package not found**: package availability differs across distributions and repositories. Update your system repositories, then adjust the relevant package list in `setup.sh` if necessary.
- **Docker needs elevated access**: the script installs Docker but does not add your user to the `docker` group or start/enable its service. Follow your distribution's Docker post-install steps if you want to run Docker without `sudo`.

## License

No license has been specified for this repository yet.
