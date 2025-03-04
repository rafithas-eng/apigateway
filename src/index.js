const express = require('express');
const bodyParser = require('body-parser');
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();
const app = express();

app.use(bodyParser.json());

// Create a part
app.post('/api/v1/peca', async (req, res) => {
  const { nome, codigo } = req.body;
  try {
    const part = await prisma.peca.create({
      data: { 
        nome, 
        codigo
      } 
    });
    res.status(201).json(part);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Create a component
app.post('/api/v1/peca/:codigo/componente', async (req, res) => {
  const { codigo } = req.params;
  const { sku, descricao, preco, quantidade } = req.body;
  try {
    const component = await prisma.componente.create({
      data: {
          codigo: parseInt(codigo),
          sku: sku,
          descricao: descricao,
          preco: preco,
          quantidade: quantidade
      }
    });
    res.status(201).json(component);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get all parts
app.get('/api/v1/peca', async (req, res) => {
  try {
    const parts = await prisma.peca.findMany();
    res.json(parts);
  } catch (error) {
    res.status(500).json({ error: "Internal server error" });
  }
});

// Get part by codigo
app.get('/api/v1/peca/:codigo', async (req, res) => {
  const { codigo } = req.params;
  try {
    const part = await prisma.peca.findUnique({
      where: { codigo: parseInt(codigo) },
    });

    if (part) {
      res.json(part);
    } else {
      res.status(404).json({ error: "Part not found" });
    }
  } catch (error) {
    res.status(500).json({ error: "Internal server error" });
  }
});

// Get component by codigo
app.get('/api/v1/peca/:codigo/componente', async (req, res) => {
  const { codigo } = req.params;
  try {
    const component = await prisma.componente.findUnique({
      where: { codigo: parseInt(codigo) },
    });

    if (component) {
      res.json(component);
    } else {
      res.status(404).json({ error: "Component not found" });
    }
  } catch (error) {
    res.status(500).json({ error: "Internal server error" });
  }
});

// Start the server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
