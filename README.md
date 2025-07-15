# Zsh config for WSL
Run the following command (Debian/Ubuntu) to install Zsh:
```bash
sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting
```
and git clone this repo in your `$HOME` directory.

## Change default shell to Zsh
Run the following command to list all available shells:
```
cat /etc/shells
```
this should output a list of all available shells on the system, including `/bin/zsh`.

Change the default shell for the current user with:
```
chsh -s <shell>
```
---
You can also change the default shell for the `root` user by running the following command:
```
sudo chsh -s <shell>
```