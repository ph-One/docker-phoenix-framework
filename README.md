# ![Logo](logo.png)

```sh
$> sudo docker pull 1986/phoenix:1.3.4
```

A docker image that can be used for all Phoenix Framework actions.
This image includes NodeJS for live reloading.

The Docker image contains the following software, and versions:
- Elixir `1.7.3`
- NodeJS `8.11.4`
- Erlang `21.0`
- Phoenix `1.3.4`

---

## How-To

### Create a new project  
```sh
$> sudo docker run --rm -it -v `pwd`:/code 1986/phoenix:1.2.0 phoenix.new helloPhoenix
$> cd HelloPhoenix
```

### Build and run your project  
```sh
$> sudo docker run --rm -it -v `pwd`:/code 1986/phoenix:1.2.0
```

---

## Roadmap
- [x] Handle all `mix` actions
- [x] `phoenix.new`
- [x] Run `phoenix.server` (default behavior of container)
