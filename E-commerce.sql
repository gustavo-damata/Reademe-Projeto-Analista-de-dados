show databases;

-- Esquema Relacional SQL
-- Criação do banco de dados para o cenário de E-commerce.

create database ecommerce;
use ecommerce;

SHOW TABLES;

-- criar tabela cliente

alter table client; 

create table client (
        idclient int auto_increment primary key,
        Fname varchar(10),
        Lname varchar (20),
        email varchar (20),
        CPF char (11) not null,
        Adress varchar(30)
        
);

-- Tabela Pedido Status

CREATE TABLE Orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') NOT NULL,
    orderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    idPayment INT,
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) REFERENCES clients(idClient)
);

-- criar tabela estoque

create TABLE productstorage (
    idProductStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quantity INT DEFAULT 0
);      

-- Criar tabela produto
 
create table product (
        idProduct int auto_increment primary key,
        Pname varchar(10) not null);

-- criar tabela fornecedor

create table supplier(      
       idSupplier int auto_increment primary key,
       SocialName varchar(255) not null,
       CNPJ char(15) not null,
       contact char(11) not null
      
);

-- criar tabela vendedor 

create table seller(      
       idseller int auto_increment primary key,
       SocialName varchar(255) not null,
       CNPJ char(15),
       contact char(11) not null
      
); 

-- Tabela Vendedor Terceiro

CREATE TABLE productSeller (
    idProductSeller INT,
    quantity INT DEFAULT 1
);

-- Forma de Pagamento 

CREATE TABLE payment (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    paymentMethod VARCHAR(255)
);

CREATE TABLE payments (
    idClient INT,
    idPayment INT,
    typePayment ENUM('Boleto', 'Cartão Débito', 'Cartão Crédito', 'Pix'),
    PRIMARY KEY(idClient, idPayment)
);

-- Status Pagamento
 
CREATE TABLE StatusPayments (
    idStatusPayments INT,
    status VARCHAR(255) CHECK (status IN ('Aprovado', 'Recusado'))
);

-- Pedido em Transporte 

ALTER TABLE OrdersTransport
ADD COLUMN trackingCode VARCHAR(255);

CREATE TABLE OrdersTransport (
    idOrdersTransport VARCHAR(255),
    
    status VARCHAR(255) CHECK (status IN ('Produto Entregue', 'Produto Recusado'))
);
       
-- criar triggers before delete e update

DELIMITER //

CREATE TRIGGER before_update_client 
BEFORE UPDATE ON client 
FOR EACH ROW 
BEGIN
select client from email where idClient = new.client;
END //

DELIMITER ;delimiter;

DELIMITER //

CREATE TRIGGER before_delete_client 
BEFORE UPDATE ON client 
FOR EACH ROW 
BEGIN
   select Adress from client where idClient = old.client;
   
END //

DELIMITER ;