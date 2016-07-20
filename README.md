# ![Logo](logo.png)

```
$> sudo docker pull 1986/phoenix:1.2.0
```

A docker image that can be used for all Phoenix Framework actions.
This image includes NodeJS for live reloading.

The Docker image contains the following software, and versions:
- Elixir 1.3.0
- NodeJS 6.2.2
- Erlang 19.0
- Phoenix 1.2.0

---

## How-To

### [_optional_] Build the image  
```sh
$> git clone https://github.com/ph-One/docker-phoenix-framework.git
$> sudo docker build -t phoenix:1.2.0 -f Dockerfile .
```

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
