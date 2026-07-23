CREATE DATABASE IF NOT EXISTS sistema_locadora;
USE sistema_locadora;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    nivel_acesso ENUM('Admin', 'Cliente') DEFAULT 'Cliente',
    cpf VARCHAR(14) NOT NULL UNIQUE,
    cnh VARCHAR(20) UNIQUE,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE veiculos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) NOT NULL UNIQUE,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano INT NOT NULL,
    valor_diaria DECIMAL(10, 2) NOT NULL,
    status ENUM('Disponivel', 'Alugado', 'Manutencao') DEFAULT 'Disponivel',
    img VARCHAR(500)
);

CREATE TABLE reservas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    veiculo_id INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    valor_total DECIMAL(10, 2),
    status ENUM('Pendente', 'Confirmada', 'Concluida', 'Cancelada') DEFAULT 'Pendente',
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (veiculo_id) REFERENCES veiculos(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO usuarios (nome, email, senha, nivel_acesso, cpf, cnh) VALUES
('Ana Silva', 'ana.silva@email.com', 'senha123', 'Cliente', '111.222.333-44', '12345678901'),
('Carlos Souza', 'carlos.souza@email.com', 'senha456', 'Cliente', '222.333.444-55', '98765432100'),
('Beatriz Rocha', 'beatriz.rocha@email.com', 'senha789', 'Cliente', '333.444.555-66', '55555555555'),
('Gerente Administrativo', 'admin@locadora.com', 'admin2026', 'Admin', '000.000.000-00', NULL);

INSERT INTO veiculos (placa, marca, modelo, ano, valor_diaria, img, status) VALUES
('ABC1D23', 'Fiat', 'Uno 1.0', 2021, 90.00, 'https://shre.ink/3i36', 'Disponivel'),
('XYZ9K87', 'Chevrolet', 'Onix Sedan', 2023, 140.00, 'https://shre.ink/3i3e', 'Alugado'),
('KGL4H22', 'Jeep', 'Compass T270', 2023, 220.00, 'https://shre.ink/3i3p', 'Disponivel'),
('MNO5X44', 'Toyota', 'Corolla Hybrid', 2024, 250.00, 'https://shre.ink/3ijF', 'Manutencao');

INSERT INTO reservas (usuario_id, veiculo_id, data_inicio, data_fim, valor_total, status) VALUES
(1, 2, '2026-05-20', '2026-05-25', 700.00, 'Confirmada'),
(2, 1, '2026-06-01', '2026-06-04', 270.00, 'Pendente'),
(3, 3, '2026-04-10', '2026-04-12', 440.00, 'Concluida'),
(4, 4, '2026-07-10', '2026-07-15', 450.00, 'Pendente');