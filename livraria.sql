CREATE SCHEMA livraria;

CREATE TABLE livraria.cliente(
 cpf INT NOT NULL,
 pnome varchar(20) NOT NULL,
 snome varchar(80) NOT NULL,
 email varchar(30) NOT NULL,
 endereco varchar(40) NOT NULL,
 CONSTRAINT pk_cliente PRIMARY KEY(cpf),
 CONSTRAINT uk_cliente UNIQUE(email)
);

CREATE SEQUENCE livraria.pedido_num
    START WITH 1 INCREMENT BY 1;
    
CREATE TABLE livraria.pedidos(
num_pedido int DEFAULT nextval('livraria.pedido_num'),
data_pedido date NOT NULL,
total_pedido numeric(10,2) NOT NULL,
cliente_cpf int,
CONSTRAINT pk_pedidos PRIMARY KEY(num_pedido),
CONSTRAINT fk_pedidos FOREIGN KEY(cliente_cpf) REFERENCES livraria.cliente(cpf)
);

CREATE SEQUENCE livraria.livro_cod
START WITH 1 INCREMENT BY 1;

CREATE TABLE livraria.livros(
cod_livro int default nextval('livraria.livro_cod'),
titulo varchar(50) NOT NULL,
autor varchar(50) NOT NULL,
editora varchar(40) NOT NULL,
preco numeric(10,2) NOT NULL,
estoque int NOT NULL,
CONSTRAINT pk_livros PRIMARY KEY (cod_livro)
);

CREATE SEQUENCE livraria.carrinho_sessao
START WITH 1 INCREMENT BY 1;

CREATE TABLE livraria.carrinho(
data_criacao date NOT NULL,
sessao int DEFAULT nextval('livraria.carrinho_sessao'),
cliente_cpf int,
num_pedido int,
CONSTRAINT pk_carrinho PRIMARY KEY (sessao,cliente_cpf),
CONSTRAINT fk_carrinho_cliente FOREIGN KEY(cliente_cpf) REFERENCES livraria.cliente(cpf),
CONSTRAINT fk_carrinho_pedido FOREIGN KEY (num_pedido) REFERENCES livraria.pedidos(num_pedido)
);

CREATE TABLE livraria.pedidolivro(
num_pedido int,
cod_livro int,
quantidade int NOT NULL,
CONSTRAINT pk_pedidolivro PRIMARY KEY (num_pedido,cod_livro),
CONSTRAINT fk_pedidolivro FOREIGN KEY(num_pedido) REFERENCES livraria.pedidos(num_pedido),
CONSTRAINT fk_livropedido FOREIGN KEY(cod_livro) REFERENCES livraria.livros(cod_livro)
);

CREATE TABLE livraria.carrinholivro(
carrinho_sessao int,
cliente_cpf int,
cod_livro int,
quantidade int NOT NULL,
CONSTRAINT pk_carrinholivro PRIMARY KEY (carrinho_sessao,cliente_cpf,cod_livro),
CONSTRAINT fk_carrinholivro FOREIGN KEY (carrinho_sessao,cliente_cpf) REFERENCES livraria.carrinho(sessao,cliente_cpf),
CONSTRAINT fk_livrocarrinho FOREIGN KEY (cod_livro) REFERENCES livraria.livros(cod_livro)
);

CREATE TABLE livraria.telefones(
num_telefone int NOT NULL,
cliente_cpf int,
CONSTRAINT pk_telefone PRIMARY KEY (num_telefone,cliente_cpf),
CONSTRAINT fk_telefone FOREIGN KEY (cliente_cpf) REFERENCES livraria.cliente(cpf)
);
