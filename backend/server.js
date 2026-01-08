const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
require('dotenv').config(); // load .env variables

const app = express();
app.use(cors());
app.use(express.json());

// Create a connection pool
const db = mysql.createPool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,   // adjust based on load
   // if using TiDB Cloud
});

console.log('connection successfu,ly')
// Test the pool


// Example route
app.get('/products', (req, res) => {
    pool.query('SELECT * FROM products', (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Database query failed' });
        }
        res.json(results);
    });
});




app.get("/select", (req, res) => {
  db.query("SELECT * FROM products", (err, result) => {
    if (err) return res.status(500).send(err);
    res.json(result);
  });
});


// Add product
app.post('/products', (req, res) => {
    const { id,name, image, description } = req.body;
    const sql = 'INSERT INTO products (id, name, image, description) VALUES (?, ?, ?, ?)'

    db.query(sql, [id,name,image, description], (err, result) => {
        
 if (err) {
      console.error(err);
      return res.status(500).json({ error: err });
    }
 res.status(201).json({
      message: 'Product added successfully',
      result,
    });
  });


    });

// Update product
app.put('/products/:id', (req, res) => {
    const id = req.params.id;
    const { name, price, description,image} = req.body;
    const sql = "UPDATE products SET name = ?, price = ?, description = ?, image = ? WHERE id = ?";
    db.query(sql, [name, price, description, image,id], (err, result) => {
        if (err) return res.status(500).send(err);
        res.json({ message: "Product updated successfully", result });
    });
});

// Delete product
app.delete('/products/:id', (req, res) => {
    const id = req.params.id;
    const sql = "DELETE FROM products WHERE id = ?";
    db.query(sql, [id], (err, result) => {
        if (err) return res.status(500).send(err);
        res.json({ message: "Product deleted successfully", result });
    });
});

// Start server
app.listen(3000, () => {
    console.log('Server running on port 3000');
});
