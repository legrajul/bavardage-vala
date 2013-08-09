# Dépendances Ubuntu
* `cmake`
* `valac` (>= 0.20)
* `libgtk-3-dev`
* `libgranite-dev` (`ppa:elementary-os/daily`)
* `libsqlheavy-dev` (`ppa:nemequ/sqlheavy`)
* `libgee-dev`

# Instructions de construction
    $ mkdir build && cd build
    build/ $ cmake ..
    build/ $ make

# Utilisation (mode debug activé)
Attention, les binaires ne sont que des tests avec des valeurs d'adresses et de ports fixées.

Dans un premier terminal :  

    build/ $ ./src/Server/bavardage-server
    
Dans un second :  

    build/ $ ./src/Client/bavardage-client
