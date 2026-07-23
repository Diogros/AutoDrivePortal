const express = require('express');
const cors = require('cors'); 
const dotenv = require('dotenv');
const path = require('path');
const veiculoController = require('./src/controllers/veiculocontroller');
const reservaController = require('./src/controllers/reservacontroller');
const authController = require('./src/controllers/authcontroller');

dotenv.config();

const app = express();

app.use(cors()); 
app.use(express.json());
app.use(express.static(path.join(__dirname, 'AutoDrivePortal')));
console.log('Servindo arquivos estáticos de:', path.join(__dirname, '..', 'AutoDrivePortal'));

app.get('/ping', (req, res) => {
    res.json({ 
        status: "online",
        mensagem: "API do Sistema de Locadora rodando perfeitamente! 🚗💨" 
    });
});

app.get('/veiculos', veiculoController.listarVeiculos);

app.post('/veiculos', veiculoController.cadastrarVeiculo);

app.post('/reservas', reservaController.criarReserva);

app.get('/reservas', reservaController.listarReservas);

app.post('/reservas', reservaController.criarReserva);

app.post('/login', authController.logarUsuario);

app.patch('/reservas/:id/status', reservaController.atualizarStatusReserva);

app.put('/veiculos/:id', veiculoController.atualizarVeiculo);


app.delete('/veiculos/:id', veiculoController.deletarVeiculo);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`🚀 Servidor HTTP iniciado na porta ${PORT}`);
    console.log(`🔗 Link de teste: http://localhost:${PORT}/ping`);
});