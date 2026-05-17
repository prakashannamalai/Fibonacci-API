const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

function fibonacci(n) {
  if (n < 0) {
    throw new Error('n must be a non-negative integer');
  }
  if (n === 0) return BigInt(0);
  if (n === 1) return BigInt(1);

  let prev = BigInt(0);
  let curr = BigInt(1);
  for (let i = 2; i <= n; i += 1) {
    const next = prev + curr;
    prev = curr;
    curr = next;
  }

  return curr;
}

app.get('/fibonacci/:n', (req, res) => {
  const raw = req.params.n;
  const n = Number(raw);

  if (!Number.isInteger(n) || n < 0) {
    return res.status(400).json({
      error: 'Parameter n must be a non-negative integer.',
      received: raw
    });
  }

  try {
    const result = fibonacci(n);
   /* return res.json({
      n,
      fibonacci: result.toString()
    });*/
    return res.send(result.toString());
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

app.get('/', (req, res) => {
  res.send('Fibonacci API is running. Use GET /fibonacci/:n');
});

app.listen(port, () => {
  console.log(`Fibonacci API listening on port ${port}`);
});
