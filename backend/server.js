const express = require('express');
const app = express();
const port = 4000; // You can choose any available port

// Middleware to parse JSON data
app.use(express.json());
app.use(express.urlencoded({extended: true}))
// Define a route for /signin
app.post('/signin', (req, res) => {
    console.log(req.body);

    res.send("ok")
});

app.post('/register', (req, res) => {
    console.log(req.body);

    res.send("ok")
});

// Start the server
app.listen("4000", () => {
  console.log(`Server is running on port ${port}`);
});