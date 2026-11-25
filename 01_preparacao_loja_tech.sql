use loja_tech;

create table categorias (
    id_categoria int auto_increment primary key,
    nome varchar(100) not null,
    descricao text,
    ativo boolean default true,
    criado_em datetime default current_timestamp
);

create table produtos (
    id_produto int auto_increment primary key,
    id_categoria int not null,
    nome varchar(200) not null,
    descricao text,
    preco decimal(10,2) not null,
    estoque int not null default 0,
    estoque_minimo int not null default 5,
    ativo boolean default true,
    criado_em datetime default current_timestamp,
    atualizado_em datetime default current_timestamp on update current_timestamp,
    constraint fk_produto_categoria
        foreign key (id_categoria) references categorias(id_categoria)
);

create table clientes (
    id_cliente int auto_increment primary key,
    nome varchar(150) not null,
    email varchar(200) not null unique,
    cpf char(11) not null unique,
    telefone varchar(15),
    data_nascimento date,
    ativo boolean default true,
    criado_em datetime default current_timestamp
);

create table pedidos (
    id_pedido int auto_increment primary key,
    id_cliente int not null,
    data_pedido datetime default current_timestamp,
    status enum('pendente','processando','enviado','entregue','cancelado') default 'pendente',
    valor_total decimal(10,2) default 0.00,
    observacao text,
    criado_em datetime default current_timestamp,
    atualizado_em datetime default current_timestamp on update current_timestamp,
    constraint fk_pedido_cliente
        foreign key (id_cliente) references clientes(id_cliente)
);

create table itens_pedido (
    id_item int auto_increment primary key,
    id_pedido int not null,
    id_produto int not null,
    quantidade int not null default 1,
    preco_unitario decimal(10,2) not null,
    subtotal decimal(10,2) generated always as (quantidade * preco_unitario) stored,
    constraint fk_item_pedido
        foreign key (id_pedido) references pedidos(id_pedido),
    constraint fk_item_produto
        foreign key (id_produto) references produtos(id_produto)
);

create table log_operacoes (
    id_log int auto_increment primary key,
    tabela_afetada varchar(100),
    operacao varchar(50),
    descricao text,
    usuario varchar(100) default (current_user()),
    data_operacao datetime default current_timestamp
);

insert into categorias (nome, descricao) values
('Notebooks', 'Notebooks e laptops'),
('Smartphones', 'Celulares e smartphones'),
('Periféricos', 'Teclados, mouses, headsets'),
('Monitores', 'Monitores e telas'),
('Armazenamento', 'HDs, SSDs e pen drives');

insert into produtos (id_categoria, nome, preco, estoque, estoque_minimo) values
(1, 'Notebook Dell Inspiron 15', 3499.90, 25, 5),
(1, 'Notebook Lenovo IdeaPad 3', 2899.00, 18, 5),
(2, 'Samsung Galaxy S24', 4299.00, 40, 10),
(2, 'iPhone 15', 6499.00, 15, 5),
(3, 'Teclado Mecânico Redragon', 249.90, 60, 10),
(3, 'Mouse Logitech G502', 349.90, 45, 10),
(3, 'Headset HyperX Cloud II', 499.90, 30, 8),
(4, 'Monitor LG UltraWide 29"', 1599.00, 12, 3),
(4, 'Monitor Samsung Curvo 27"', 1899.00, 10, 3),
(5, 'SSD Kingston 480GB', 219.90, 80, 15),
(5, 'HD Externo Seagate 1TB', 329.90, 35, 8);

insert into clientes (nome, email, cpf, telefone, data_nascimento) values
('Ana Silva', 'ana.silva@email.com', '12345678901', '11987654321', '1995-03-15'),
('Bruno Oliveira', 'bruno.oliveira@email.com', '23456789012', '11976543210', '1990-07-22'),
('Carla Santos', 'carla.santos@email.com', '34567890123', '21965432109', '1988-11-08'),
('Daniel Costa', 'daniel.costa@email.com', '45678901234', '31954321098', '2000-01-30'),
('Elena Ferreira', 'elena.ferreira@email.com', '56789012345', '41943210987', '1998-06-12');

insert into pedidos (id_cliente, status, valor_total) values
(1, 'entregue', 3749.80),
(2, 'enviado', 4299.00),
(3, 'pendente', 1099.70),
(1, 'processando', 6499.00),
(4, 'cancelado', 249.90);

insert into itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) values
(1, 1, 1, 3499.90),
(1, 5, 1, 249.90),
(2, 3, 1, 4299.00),
(3, 6, 1, 349.90),
(3, 5, 3, 249.90),
(4, 4, 1, 6499.00),
(5, 5, 1, 249.90);

show tables;

select 'categorias' as tabela, count(*) as registros from categorias
union all select 'produtos', count(*) from produtos
union all select 'clientes', count(*) from clientes
union all select 'pedidos', count(*) from pedidos
union all select 'itens_pedido', count(*) from itens_pedido;
