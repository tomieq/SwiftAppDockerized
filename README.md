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
RUN echo $(ls -la .build | grep linux)


FROM swift:5.7-slim
RUN apt-get update -y
RUN apt-get install -y file
WORKDIR /app
COPY --from=builder /app/.build/x86_64-unknown-linux-gnu/release/SwiftApp .
COPY Resources /app/Resources
CMD ["./SwiftApp"]
```
### Running 
```
docker run --rm -it --name swift_app_1 --env URL=traffic.com/open-telemetry tomieq/swift_app:1.0
```
Our sample app will output:
```
workingDir: /app
file:///app/
├── Resources
│   └── binary.data
└── SwiftApp

invoke ➡️   file /app/SwiftApp
/app/SwiftApp: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, with debug_info, not stripped
invoke ➡️   ldd /app/SwiftApp
    linux-vdso.so.1 (0x00007fff3e3a4000)
    libFoundation.so => /usr/lib/swift/linux/libFoundation.so (0x00007f5394287000)
    libswift_StringProcessing.so => /usr/lib/swift/linux/libswift_StringProcessing.so (0x00007f53941bb000)
    libswiftGlibc.so => /usr/lib/swift/linux/libswiftGlibc.so (0x00007f53941a7000)
    libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f53940be000)
    libswiftDispatch.so => /usr/lib/swift/linux/libswiftDispatch.so (0x00007f539408e000)
    libdispatch.so => /usr/lib/swift/linux/libdispatch.so (0x00007f539402b000)
    libBlocksRuntime.so => /usr/lib/swift/linux/libBlocksRuntime.so (0x00007f5394026000)
    libswift_Concurrency.so => /usr/lib/swift/linux/libswift_Concurrency.so (0x00007f5393fc4000)
    libswiftCore.so => /usr/lib/swift/linux/libswiftCore.so (0x00007f5393966000)
    libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f539373e000)
    libicuucswift.so.65 => /usr/lib/swift/linux/libicuucswift.so.65 (0x00007f5393545000)
    libicui18nswift.so.65 => /usr/lib/swift/linux/libicui18nswift.so.65 (0x00007f539323d000)
    libicudataswift.so.65 => /usr/lib/swift/linux/libicudataswift.so.65 (0x00007f539178c000)
    libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f539176c000)
    libswift_RegexParser.so => /usr/lib/swift/linux/libswift_RegexParser.so (0x00007f539164a000)
    libstdc++.so.6 => /lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f539141e000)
    /lib64/ld-linux-x86-64.so.2 (0x00007f5394b38000)
Enviromental variale URL: traffic.com/open-telemetry
```
