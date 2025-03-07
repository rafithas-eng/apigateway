# apigateway

Trabalho faculdade Impacta

## Description

This project is an API Gateway built with Express.js and Prisma. It provides endpoints to manage parts (`Peca`) and their components (`Componente`).

## Prerequisites

- Node.js (v14 or higher)
- npm (v6 or higher)
- MySQL database

## Setup

### 1. Clone the repository

```sh
git clone https://github.com/yourusername/apigateway.git
cd apigateway
```

### 2. Install dependencies
```sh
npm install
```
### 3. Run the all Services Docker container

Run the following command to start the Postgree, and Kong container:

```sh
docker-compose -f 'docker-compose.yml' up -d --build 
docker run -d  'kong-migrations' 
docker run -d  'kong' 
```

### 4. Migrate the database

Run the following command to apply the migrations and set up your database schema:

```sh
npx prisma migrate dev --name init
```

### 5. Start the server

```sh
npm start
```

The server will start running on `http://localhost:3000`.


### 6. Genetared Routes 

```sh
./criarServicos.sh
```

Create product Peca - http://localhost:3000/api/v1/peca

Create route Peca - http://localhost:8000/v1/gateway/peca

## API Endpoints

### Create a Part

**POST** `/api/v1/peca`

Request Body:
```json
{
  "nome": "Peca A",
  "codigo": 1,
  "componente": {
    "codigo": 1,
    "sku": "SKU123",
    "descricao": "Description of the component",
    "preco": 100.0,
    "quantidade": 10
  }
}
```

### Create a Component for a Part

**POST** `/api/v1/peca/:codigo/componente`

Request Body:
```json
{
  "sku": "SKU123",
  "descricao": "Description of the component",
  "preco": 100.0,
  "quantidade": 10
}
```

### Get All Parts

**GET** `/api/v1/peca`

### Get Part by Codigo

**GET** `/api/v1/peca/:codigo`

### Get Component by Codigo

**GET** `/api/v1/peca/:codigo/componente`

