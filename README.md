# ![Logo](logo.png)

```sh
$> sudo docker pull 1986/phoenix:1.2.1
```

A docker image that can be used for all Phoenix Framework actions.
This image includes NodeJS for live reloading.

The Docker image contains the following software, and versions:
- Elixir `1.3.3`
- NodeJS `6.7.0`
- Erlang `19.0`
- Phoenix `1.2.1`

---

## How-To

### [_optional_] Build the image  
```sh
$> git clone https://github.com/ph-One/docker-phoenix-framework.git
$> sudo docker build -t phoenix:1.2.1 -f Dockerfile .
```

### Create a new project  
```sh
$> sudo docker run --rm -it -v `pwd`:/code 1986/phoenix:1.2.1 phoenix.new helloPhoenix
$> cd HelloPhoenix
```

### Build and run your project  
```sh
$> sudo docker run --rm -it -v `pwd`:/code 1986/phoenix:1.2.1
```

---

## Roadmap
- [x] Handle all `mix` actions
- [x] `phoenix.new`
- [x] Run `phoenix.server` (default behavior of container)
