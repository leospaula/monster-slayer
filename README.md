# Monster Slayer

Game designed to serve as the basis for a trophy system.

Run bundle:

```sh
bundle install
```

Create and migrate DB:

```sh
rake db:create && rake db:migrate
```

Run seeds:

```sh
ruby db/seeds.rb
```

Run the game:

```sh
ruby lib/main.rb
```

Commands:

```
N - Start Game
ESC - Pause Game and show Stats
T - Adds monster to WorldMap
Q - Quit Game
```

Some assets sourced from [OpenGameArt.org](https://opengameart.org)