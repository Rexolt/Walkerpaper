#!/bin/bash


SOURCE_DIR="wallpapers"

TARGET_DIR="$HOME/.local/share/backgrounds"


SUPPORTED_FORMATS=("jpg" "jpeg" "png" "bmp" "tiff")


DEFAULT_BACKUP_WALLPAPER="/usr/share/backgrounds/default.jpg"  # Ez a disztribúciótól függően változhat


install_wallpapers() {
  echo "Háttérképek másolása a $TARGET_DIR könyvtárba..."
  mkdir -p "$TARGET_DIR"

  for format in "${SUPPORTED_FORMATS[@]}"; do
    find "$SOURCE_DIR" -type f -iname "*.$format" -exec cp {} "$TARGET_DIR" \;
  done

  DESKTOP_ENV=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')

  echo "Felismert asztali környezet: $DESKTOP_ENV"

  if [[ "$DESKTOP_ENV" == *"gnome"* || "$DESKTOP_ENV" == *"cinnamon"* ]]; then
    echo "GNOME vagy Cinnamon környezet észlelve. Háttérkép beállítása..."

    DEFAULT_WALLPAPER=$(find "$TARGET_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" -o -iname "*.tiff" \) | head -n 1)
    if [ -n "$DEFAULT_WALLPAPER" ]; then
      echo "Az alapértelmezett háttérkép beállítása: $DEFAULT_WALLPAPER"
      gsettings set org.gnome.desktop.background picture-uri "file://$DEFAULT_WALLPAPER"
      gsettings set org.gnome.desktop.background picture-options "zoom"
    fi

  elif [[ "$DESKTOP_ENV" == *"kde"* ]]; then
    echo "KDE Plasma környezet észlelve. Háttérkép beállítása..."

    plasmashell_script=$(cat <<EOF
var allDesktops = desktops();
for (i = 0; i < allDesktops.length; i++) {
    d = allDesktops[i];
    d.wallpaperPlugin = "org.kde.image";
    d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");
    d.writeConfig("Image", "file://$TARGET_DIR/$(basename $(find "$TARGET_DIR" -type f -name "*.jpg" | head -n 1))");
}
EOF
    )

    echo "$plasmashell_script" | qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript
  else
    echo "Ismeretlen vagy nem támogatott asztali környezet. Csak a háttérképek másolása történt meg."
  fi

  echo "A háttérképek sikeresen telepítve és használatra készen állnak!"
}


remove_wallpapers() {
  echo "Telepített háttérképek eltávolítása a $TARGET_DIR könyvtárból..."


  if [ -d "$TARGET_DIR" ]; then
    rm -rf "$TARGET_DIR"
    echo "Háttérképek törölve a $TARGET_DIR könyvtárból."
  else
    echo "Nincsenek telepített háttérképek a $TARGET_DIR könyvtárban."
  fi


  DESKTOP_ENV=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')

  if [[ "$DESKTOP_ENV" == *"gnome"* || "$DESKTOP_ENV" == *"cinnamon"* ]]; then
    echo "GNOME vagy Cinnamon környezet észlelve. Alapértelmezett háttérkép visszaállítása..."
    gsettings set org.gnome.desktop.background picture-uri "file://$DEFAULT_BACKUP_WALLPAPER"
    gsettings set org.gnome.desktop.background picture-options "zoom"
  elif [[ "$DESKTOP_ENV" == *"kde"* ]]; then
    echo "KDE Plasma környezet észlelve. Alapértelmezett háttérkép visszaállítása..."
    
    plasmashell_script=$(cat <<EOF
var allDesktops = desktops();
for (i = 0; i < allDesktops.length; i++) {
    d = allDesktops[i];
    d.wallpaperPlugin = "org.kde.image";
    d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");
    d.writeConfig("Image", "file://$DEFAULT_BACKUP_WALLPAPER");
}
EOF
    )

    echo "$plasmashell_script" | qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript
  else
    echo "Ismeretlen vagy nem támogatott asztali környezet. Az alapértelmezett háttérkép nem állítható vissza automatikusan."
  fi

  echo "Eltávolítás befejezve!"
}


case "$1" in
  install)
    install_wallpapers
    ;;
  remove)
    remove_wallpapers
    ;;
  *)
    echo "Használat: $0 [install|remove]"
    echo "  install - Háttérképek telepítése"
    echo "  remove  - Telepített háttérképek eltávolítása"
    ;;
esac
