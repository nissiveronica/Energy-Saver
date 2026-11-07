const express = require("express");
const cors = require("cors");
const mysql = require("mysql2/promise");

const app = express();

app.use(cors());
app.use(express.json());

const db = mysql.createPool({
  host: "127.0.0.1",
  user: "root",
  password: "nissi@3008",
  database: "energy_saver_db",
  port: 3306,
});

app.get("/", (req, res) => {
  res.json({
    success: true,
    message: "Energy Saver API is running",
  });
});

app.get("/test-db", async (req, res) => {
  try {
    const [rows] = await db.query("SELECT 1 AS connected");

    res.json({
      success: true,
      message: "MySQL database connected successfully",
      data: rows,
    });
  } catch (error) {
    console.error(error);

    res.status(500).json({
      success: false,
      message: "MySQL connection failed",
      error: error.message,
    });
  }
});

const PORT = 3000;

app.listen(PORT, () => {
  console.log(`Energy Saver API running at http://localhost:${PORT}`);
});