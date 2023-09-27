# SwiftApp

Skeleton Swift app showing how to pack it into Docker container

## Building docker image

```
docker build -t tomieq/swift_app:1.0 .
``` 
tag name might have only lower case letters


If there is some issue with `swift build` folder, start with: `docker build --progress plain  .`
Adding `RUN echo $(ls -la .build | grep linux)` to Dokerfile

### Dockerfile
```
FROM swift:5.7 as builder
WORKDIR /app
COPY . .
RUN swift build -c release 

FROM swift:5.7-slim
WORKDIR /app
COPY --from=builder /app/.build/x86_64-unknown-linux/release/SwiftApp .
COPY Resources /app/Resources
CMD ["./SwiftApp"]
```
### Running 
```
docker run --rm -it --name swift_app_1 tomieq/swift_app:1.0
```
