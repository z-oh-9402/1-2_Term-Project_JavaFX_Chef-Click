# MobileFood

A food-ordering desktop app written in Java with JavaFX. A central server connects
**restaurant** clients and **customer** clients over sockets (port 12345): restaurants
manage their menu and orders, customers search, order and chat.

## Requirements
- JDK 17 or newer
- JavaFX (OpenJFX)
  - Ubuntu/Debian: `sudo apt install openjfx`
  - macOS: `brew install openjfx`
  - Otherwise download the SDK from <https://gluonhq.com/products/javafx/> and set
    `JAVAFX_LIB=/path/to/javafx-sdk/lib` before running the commands below.
  - Some JavaFX warnings in the console (version mismatch, `Unsafe`) are harmless.

## Run
Open three terminals in the project folder:

```bash
./run.sh server       # 1. start first, keep running (prints "Server started ...")
./run.sh restaurant   # 2. restaurant app
./run.sh customer     # 3. customer app
```

The script compiles automatically when sources change. `./run.sh build` compiles only,
`./run.sh clean` removes the build output.

Run the server from the project folder: it reads and writes `restaurant.txt`,
`customer.txt` and `menu.txt` in `datafiles/`. You can start several restaurant and customer clients.

## Try it
1. Register a restaurant in the restaurant app and add some food to its menu.
2. Register a customer in the customer app, find the restaurant, and place an order.
3. Use the chat and order pages on both sides.

## Layout
- `src/mobilefood/Server.java` - the server
- `src/mobilefood/restaurant`, `src/mobilefood/customer` - the two JavaFX clients (controllers + FXML)
- `src/mobilefood/passableobjects` - objects sent over the network
- `src/networking` - socket wrapper and read threads
- `src/images` - all images (loaded from the classpath)
- `datafiles` - `restaurant.txt`, `customer.txt`, `menu.txt`: the data files the server reads and writes

## Windows
`run.sh` needs a bash shell (Git Bash or WSL). Otherwise compile and run with
`javac`/`java` and `--module-path <javafx>\lib --add-modules javafx.controls,javafx.fxml`,
using `out` as the classpath and copying the `.fxml`/`.css` files and the `images` folder from `src` into `out`.
