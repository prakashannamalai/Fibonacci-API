# Fibonacci API

Node.js REST API that returns the nth Fibonacci number.

## Endpoints

- `GET /fibonacci/:n` - Returns the Fibonacci number at index `n`.

## Example

Request:

```bash
curl http://localhost:3000/fibonacci/10
```

Response:

```
55
```

## Docker

Build the image:

```bash
docker build -t fibonacci-api .
```

Run the container:

```bash
docker run -p 3000:3000 fibonacci-api
```
