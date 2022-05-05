-- Criar banco de dados.
CREATE DATABASE exemplo;

-- Usar banco do dados.
USE exemplo;

-- Criar tabelas.
CREATE TABLE cliente(
	codigo int not null primary key auto_increment,
    nome VARCHAR(50) not null,
    cep VARCHAR(8) not null,
    endereco VARCHAR(50) not null,
    numero INT not null,
    complemento VARCHAR(50),
    bairro VARCHAR(40) not null,
    cidade VARCHAR(40) not null,
    estado VARCHAR(2) not null,
    rendaMensal decimal (10,2) not null,
    limiteCredito decimal (10,2) not null    
);

-- CRUD para operações mobile, a sintaxe terá que ser adequada para o uso do SQLite.
-- CREATE / INSERT.
insert into cliente values 
(null, 'Zé da Pena', '12345678', 'Rua das Pendangas', '144', 'Hadouken', 'Vaquejada', 'São Tomás de Aquino', 'MG', 61461.00, 8787.00),
(null, 'Bruno Kandry', '13188030', 'Rua Carlos Chagas', '666', 'Malagasy is good', 'Jardim Amanda', 'Hortolândia', 'SP', 5000.00, 1045.00),
(null, 'Sebastião Willian', '29161112', 'Rua Paraíso', '70', 'IPB Jardim Tropical', 'Jardim Tropical', 'Serra', 'ES', 7000.00, 5412.00);

-- READ / SELECT. #Buscar todos cadastrados.
select * from cliente;

-- UPDATE
-- Fazer validação se o novo código é existente.
UPDATE cliente set nome = 'João da Perereca', cep = '87654321', endereco = 'Rua do bobos', numero = 0, complemento = 'Ninguém podia dormir', bairro = 'Imaginário', cidade = 'Fantasma', estado = 'BA', rendaMensal = 0, limiteCredito = 0 where codigo = 1;  

-- DELETE - Excluir cliente com base no código.
DELETE from cliente where codigo = 1;