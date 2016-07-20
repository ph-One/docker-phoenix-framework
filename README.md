# ![Logo](logo.png)

A docker image that can be used for all Phoenix Framework actions.

## How-To
1. [_optional_] Build the image
```sh
$> git clone https://github.com/ph-One/docker-phoenix-framework.git
$> sudo docker build -f Dockerfile .
```

2. Create a new project
```sh
$> sudo docker run --rm -it -v `pwd`:/code 1986/phoenix:1.2.0 phoenix.new HelloPhoenix
$> cd HelloPhoenix
```

3. Build and run your project
```sh
$> sudo docker run --rm -it -v `pwd`:/code 1986/phoenix:1.2.0
```

## Roadmap
- [x] Handle all `mix` actions
- [x] `phoenix.new`
- [x] Run `phoenix.server` (default behavior of container)
