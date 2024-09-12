FROM swift:5.9 as builder
WORKDIR /app
COPY . .
RUN swift build -c release
# aarch64-unknown-linux-gnu for raspberry pi
# x86_64-unknown-linux-gnu for intel based architectures
RUN mkdir output
RUN cp $(swift build --show-bin-path -c release)/SwiftApp output/App
RUN strip -s output/App

FROM swift:5.9-slim
RUN apt-get update -y
RUN apt-get install -y file
WORKDIR /app
COPY --from=builder /app/output/App .
COPY Resources /app/Resources
CMD ["./App"]
