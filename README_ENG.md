

Walkerpaper
===========

Description
-----------

Walkerpaper is a Linux wallpaper manager designed for simplicity and automation. It enables users to:

*   Install wallpapers from a specified directory.
*   Automatically make wallpapers available in the system wallpaper chooser for supported desktop environments (GNOME, Cinnamon, KDE Plasma).
*   Set a default wallpaper immediately after installation.
*   Remove installed wallpapers and reset the default wallpaper.

Features
--------

*   Supports multiple file formats: `.jpg`, `.jpeg`, `.png`, `.bmp`, `.tiff`.
*   Automatically detects the desktop environment and applies changes accordingly.
*   Adds wallpapers to the wallpaper chooser instantly.
*   Includes a `remove` command to clean up installed wallpapers and reset to system defaults.
*   Compatible with GNOME, Cinnamon, and KDE Plasma desktop environments.

Requirements
------------

*   **GNOME/Cinnamon**: Ensure `gsettings` is installed:
    
        sudo apt install dconf-cli
    
*   **KDE Plasma**: Ensure `qdbus` is installed:
    
        sudo apt install qdbus
    
*   Linux operating system.

Installation
------------

1.  Clone or download this repository.
2.  Make the `install.sh` script executable:
    
        chmod +x install.sh
    
3.  Place your wallpapers in the `wallpapers/` directory (create the directory if it doesn’t exist).

Usage
-----

### Install Wallpapers

To install wallpapers and make them available immediately in the wallpaper chooser, run:

    ./install.sh install

*   Wallpapers are copied to the `~/.local/share/backgrounds/` directory.
*   The first wallpaper found is set as the default background.
*   Wallpapers are automatically added to the system wallpaper chooser.

### Remove Wallpapers

To remove wallpapers and reset the system default wallpaper, run:

    ./install.sh remove

*   Deletes the wallpapers from `~/.local/share/backgrounds/`.
*   Resets the desktop background to the system's default wallpaper.

### Help

To see available commands, run the script without arguments:

    ./install.sh

How It Works
------------

1.  **Installation Process**:
    *   Copies all supported wallpaper files (`.jpg`, `.jpeg`, `.png`, `.bmp`, `.tiff`) from the `wallpapers/` directory to `~/.local/share/backgrounds/`.
    *   Detects the current desktop environment using the `$XDG_CURRENT_DESKTOP` variable.
    *   Sets the first wallpaper as the default background and makes all wallpapers available in the chooser.
2.  **Removal Process**:
    *   Deletes all wallpapers from the `~/.local/share/backgrounds/` directory.
    *   Resets the desktop background to the system's default wallpaper.
3.  **Desktop Environment Support**:
    *   **GNOME/Cinnamon**: Uses `gsettings` to update the background and wallpaper chooser.
    *   **KDE Plasma**: Uses `qdbus` to dynamically update the background.
    *   **Other Environments**: Copies the wallpapers to the target directory; manual setup may be required.

Testing
-------

1.  Place sample wallpapers in the `wallpapers/` directory.
2.  Run the installation command:
    
        ./install.sh install
    
3.  Open the wallpaper settings menu in your desktop environment and confirm the wallpapers appear.
4.  Run the removal command:
    
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

Ensure the `DEFAULT_BACKUP_WALLPAPER` variable in the script points to a valid image.

### Logs

To capture logs for debugging, run:

    
    ./install.sh install | tee install.log
    ./install.sh remove | tee remove.log
        

Customization
-------------

*   **Default Wallpaper**:
    
    Modify the `DEFAULT_BACKUP_WALLPAPER` variable in the script to point to the system's default wallpaper path:
    
        DEFAULT_BACKUP_WALLPAPER="/path/to/default.jpg"
    
*   **Add Support for More Formats**:
    
    Edit the `SUPPORTED_FORMATS` array in the script to include additional file extensions:
    
        SUPPORTED_FORMATS=("jpg" "jpeg" "png" "bmp" "tiff" "webp")
    

License
-------

Walkerpaper is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.
