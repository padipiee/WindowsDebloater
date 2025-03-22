#!/bin/bash
# Install ncursesw development libraries on Debian-based systems

# Update package lists
sudo apt update

# Install libncursesw development package
sudo apt install -y libncursesw5-dev

# Alternative packages that might be needed depending on the specific requirement
# sudo apt install -y libncurses-dev  # For general ncurses development files
# sudo apt install -y ncurses-dev     # Meta-package for ncurses development

echo "Installed ncursesw development libraries"
