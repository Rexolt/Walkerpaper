 Walkerpaper

Wallpaper Installer Script
==========================

Description
-----------

This script is a simple and efficient solution for managing wallpapers on Linux systems. It allows users to:

*   Install wallpapers from a specific directory.
*   Automatically add them to the wallpaper chooser in supported desktop environments (GNOME, Cinnamon, KDE Plasma).
*   Set one of the wallpapers as the default.
*   Remove installed wallpapers and reset the default wallpaper.

Features
--------

*   Supports multiple file formats: `.jpg`, `.jpeg`, `.png`, `.bmp`, `.tiff`.
*   Automatically detects the desktop environment and applies changes accordingly.
*   Instantly adds wallpapers to the wallpaper chooser.
*   Includes a `remove` option to clean up installed wallpapers and reset to defaults.
*   Compatible with GNOME, Cinnamon, and KDE Plasma desktop environments.

Requirements
------------

*   **GNOME/Cinnamon**: Ensure `gsettings` is installed.

    sudo apt install dconf-cli

*   **KDE Plasma**: Ensure `qdbus` is installed.

    sudo apt install qdbus

*   Linux operating system.

Installation
------------

1.  Clone or download this repository.
2.  Ensure the `install.sh` script is executable:
    
        chmod +x install.sh
    
3.  Place your wallpapers in the `wallpapers/` directory (create the directory if it doesn’t exist).

Usage
-----

### Install Wallpapers

To install wallpapers and make them available immediately in the wallpaper chooser, run:

    ./install.sh install

*   Wallpapers are copied to the `~/.local/share/backgrounds/` directory.
*   The first wallpaper found is set as the default background.
*   The wallpapers are added to the wallpaper chooser for supported desktop environments.

### Remove Wallpapers

To remove wallpapers and reset to the default wallpaper, run:

    ./install.sh remove

*   Deletes the wallpapers from `~/.local/share/backgrounds/`.
*   Resets the desktop background to the system default.

### Help

If you need a reminder of the available commands, run the script without arguments:

    ./install.sh

How It Works
------------

1.  **Installation Process**:
    *   Copies all supported wallpaper files (`.jpg`, `.jpeg`, `.png`, `.bmp`, `.tiff`) from the `wallpapers/` directory to `~/.local/share/backgrounds/`.
    *   Detects the current desktop environment using the `$XDG_CURRENT_DESKTOP` variable.
    *   Sets the first wallpaper as the default background and ensures all wallpapers are added to the chooser.
2.  **Removal Process**:
    *   Deletes all wallpapers from the `~/.local/share/backgrounds/` directory.
    *   Resets the background to the system's default wallpaper.
3.  **Desktop Environment Support**:
    *   **GNOME/Cinnamon**: Uses `gsettings` to update the background and wallpaper chooser.
    *   **KDE Plasma**: Uses `qdbus` to dynamically update the background.
    *   **Other Environments**: Only copies the wallpapers; manual setup may be required.

Testing
-------

1.  Place sample wallpapers in the `wallpapers/` directory.
2.  Run the installation command:
    
        ./install.sh install
    
3.  Open your wallpaper settings menu to confirm the wallpapers appear and one is set as the default.
4.  Test the removal command:
    
        ./install.sh remove
    
5.  Confirm the wallpapers are removed and the default wallpaper is restored.

Troubleshooting
---------------

### Wallpapers Do Not Appear in the Chooser

*   **GNOME/Cinnamon**: Ensure `gsettings` is installed:
    
        sudo apt install dconf-cli
    
*   **KDE Plasma**: Ensure `qdbus` is installed:
    
        sudo apt install qdbus
    

### Default Wallpaper Not Restored

Verify the `DEFAULT_BACKUP_WALLPAPER` variable in the script points to a valid image.

### Logs

To capture logs for debugging:

    
    ./install.sh install | tee install.log
    ./install.sh remove | tee remove.log
        

Customization
-------------

*   **Default Wallpaper**:
    
    Modify the `DEFAULT_BACKUP_WALLPAPER` variable in the script to match the path of your system's default wallpaper:
    
        DEFAULT_BACKUP_WALLPAPER="/path/to/default.jpg"
    
*   **Add Support for More Formats**:
    
    Edit the `SUPPORTED_FORMATS` array in the script to include additional file extensions:
    
        SUPPORTED_FORMATS=("jpg" "jpeg" "png" "bmp" "tiff" "webp")
    

License
-------

This project is open-source and available for use and modification under the [MIT License](LICENSE).
