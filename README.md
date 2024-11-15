

Walkerpaper Projekt
=======================

Leírás
------

Ez a projekt egy egyszerű és hatékony megoldás a háttérképek kezelésére Linux rendszeren. A projekt tartalmaz:

*   Előre telepített, stílusokra bontott háttérképeket.
*   Egy `install.sh` telepítő scriptet, amely a háttérképeket azonnal elérhetővé teszi a rendszer háttérkép választójában.
*   Egy `remove` funkciót, amely eltávolítja a telepített háttérképeket és visszaállítja az alapértelmezett háttérképet.

Funkciók
--------

*   Több fájlformátum támogatása: `.jpg`, `.jpeg`, `.png`, `.bmp`, `.tiff`.
*   Automatikus asztali környezet felismerés (GNOME, Cinnamon, KDE Plasma).
*   Azonnali hozzáadás a háttérkép választóhoz.
*   Előre telepített háttérképek, amelyek több stílusban érhetők el (természet, minimalista, városi tájkép, stb.).

Követelmények
-------------

*   **GNOME/Cinnamon**: A `gsettings` telepítve legyen:
    
        sudo apt install dconf-cli
    
*   **KDE Plasma**: A `qdbus` telepítve legyen:
    
        sudo apt install qdbus
    
*   Linux operációs rendszer.

Telepítés
---------

1.  Clone-ozd vagy töltsd le a projektet.
2.  Győződj meg róla, hogy az `install.sh` script futtatható:
    
        chmod +x install.sh
    
3.  Az előre telepített háttérképek már megtalálhatók a `wallpapers/` könyvtárban, stílusokra bontva.

Használat
---------

### Háttérképek telepítése

Futtasd az alábbi parancsot a háttérképek telepítéséhez:

    ./install.sh install

*   A háttérképek átmásolódnak a `~/.local/share/backgrounds/` könyvtárba.
*   Az első található háttérkép automatikusan alapértelmezettként lesz beállítva.
*   A háttérképek azonnal elérhetők a háttérkép választóban.

### Háttérképek eltávolítása

Futtasd az alábbi parancsot a telepített háttérképek eltávolításához:

    ./install.sh remove

*   A háttérképek törlődnek a `~/.local/share/backgrounds/` könyvtárból.
*   A rendszer visszaáll az alapértelmezett háttérképre.

### Súgó

Ha emlékeztetőre van szükséged a parancsokhoz, futtasd a scriptet argumentumok nélkül:

    ./install.sh

Előre telepített háttérképek
----------------------------

A projekt tartalmaz előre telepített háttérképeket az alábbi stílusok szerint:

*   **Természet:** Hegyek, tavak, erdők.
*   **Minimalista:** Egyszerű, tiszta design.
*   **Városi tájkép:** Felhőkarcolók, utcák.
*   **Absztrakt:** Színes minták, művészi kompozíciók.

A képek megtalálhatók a `wallpapers/` könyvtárban, és telepítés után azonnal elérhetők lesznek.

Működés
-------

1.  **Telepítés**:
    *   Az `wallpapers/` könyvtárban található támogatott fájlokat (`.jpg`, `.png`, stb.) átmásolja a `~/.local/share/backgrounds/` mappába.
    *   Felismeri az aktuális asztali környezetet az `$XDG_CURRENT_DESKTOP` változó alapján.
    *   Az első háttérképet automatikusan alapértelmezettként állítja be.
2.  **Eltávolítás**:
    *   Törli az összes háttérképet a `~/.local/share/backgrounds/` könyvtárból.
    *   Visszaállítja az alapértelmezett háttérképet.

Hibaelhárítás
-------------

### Nem jelennek meg a háttérképek

*   **GNOME/Cinnamon**: Győződj meg róla, hogy a `gsettings` telepítve van:
    
        sudo apt install dconf-cli
    
*   **KDE Plasma**: Győződj meg róla, hogy a `qdbus` telepítve van:
    
        sudo apt install qdbus
    

### Az alapértelmezett háttérkép nem áll vissza

Ellenőrizd, hogy a `DEFAULT_BACKUP_WALLPAPER` változó helyes képre mutat a scriptben.

### Naplózás

A script kimenetét naplózhatod a hibák egyszerűbb megoldásához:

    
    ./install.sh install | tee install.log
    ./install.sh remove | tee remove.log
        

Testreszabás
------------

*   **Alapértelmezett háttérkép**:
    
    A `DEFAULT_BACKUP_WALLPAPER` változó beállításával megadhatod az alapértelmezett háttérképet:
    
        DEFAULT_BACKUP_WALLPAPER="/path/to/default.jpg"
    
*   **További formátumok támogatása**:
    
    Az `SUPPORTED_FORMATS` tömb bővítésével új fájlformátumokat adhatsz hozzá:
    
        SUPPORTED_FORMATS=("jpg" "jpeg" "png" "bmp" "tiff" "webp")
    

Licenc
------

A projekt nyílt forráskódú, és az [GNU Licenc](LICENSE) alatt elérhető.
