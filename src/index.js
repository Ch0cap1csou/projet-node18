import express from "express";

const app = express();
const port = 3000;

app.get("/", (req, res) => {
  res.send("Hello depuis mon app Node 18 !");
});

app.listen(port, () => {
  console.log(`Serveur lancé sur http://localhost:${port}`);
});