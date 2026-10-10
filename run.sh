#!/usr/bin/env bash
# Usage: ./run.sh <server|restaurant|customer|build|clean>
# Needs JDK 17+ and JavaFX. Set JAVAFX_LIB to your JavaFX "lib" folder if it is not auto-detected.
set -e
cd "$(dirname "$0")"   # the server reads/writes the .txt data files from here

find_javafx() {
    local d
    for d in "$JAVAFX_LIB" /usr/share/openjfx/lib /usr/lib/jvm/openjfx/lib \
             /opt/homebrew/opt/openjfx/libexec/lib /usr/local/opt/openjfx/libexec/lib \
             "$HOME"/javafx-sdk*/lib "$HOME"/Downloads/javafx-sdk*/lib ./javafx-sdk*/lib; do
        if [ -n "$d" ] && [ -f "$d/javafx.base.jar" ]; then echo "$d"; return; fi
    done
}

FX="$(find_javafx)"
if [ -z "$FX" ]; then
    echo "JavaFX not found. Install it (Ubuntu/Debian: sudo apt install openjfx)"
    echo "or download the SDK from https://gluonhq.com/products/javafx/ and run:"
    echo "  JAVAFX_LIB=/path/to/javafx-sdk/lib ./run.sh $1"
    exit 1
fi
MODS="--module-path $FX --add-modules javafx.controls,javafx.fxml"

build() {
    mkdir -p out
    javac $MODS -d out $(find src -name '*.java')
    (cd src && find . \( -name '*.fxml' -o -name '*.css' -o -path './images/*' \) -type f -exec cp --parents {} ../out \;)
    touch out/.built
}

# Rebuild automatically when sources changed since the last build.
needs_build() {
    [ ! -f out/.built ] || [ -n "$(find src -newer out/.built -type f | head -1)" ]
}

case "$1" in
    build)      build ;;
    clean)      rm -rf out ;;
    server)     needs_build && build; exec java -cp out mobilefood.Server ;;
    restaurant) needs_build && build; exec java $MODS --enable-native-access=javafx.graphics -cp out mobilefood.restaurant.RestaurantMain ;;
    customer)   needs_build && build; exec java $MODS --enable-native-access=javafx.graphics -cp out mobilefood.customer.CustomerMain ;;
    *)          echo "Usage: ./run.sh <server|restaurant|customer|build|clean>"; exit 1 ;;
esac
