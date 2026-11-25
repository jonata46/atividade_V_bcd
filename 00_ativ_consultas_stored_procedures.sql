
use loja_tech;

select nome, email
from clientes;

select nome, preco
from produtos
where preco < 500.00;

select *
from pedidos
where status = 'pendente';

select nome, preco
from produtos
order by preco desc;

select id_produto, nome, preco
from produtos
where nome like '%monitor%';

select nome, estoque
from produtos
where id_categoria = 3
  and estoque > 40;

select count(*) as total_clientes
from clientes;

select sum(valor_total) as faturamento_bruto
from pedidos;

select p.nome as produto, c.nome as categoria
from produtos p
inner join categorias c on c.id_categoria = p.id_categoria;

select pe.id_pedido, pe.status, pe.valor_total
from pedidos pe
inner join clientes cl on cl.id_cliente = pe.id_cliente
where cl.nome = 'ana silva';

drop procedure if exists listar_categorias_ativas;
delimiter //
create procedure listar_categorias_ativas()
begin
    select id_categoria, nome, descricao
    from categorias
    where ativo = true
    order by nome asc;
end //
delimiter ;

drop procedure if exists buscar_pedidos_por_status;
delimiter //
create procedure buscar_pedidos_por_status(
    in p_status varchar(20)
)
begin
    select id_pedido, id_cliente, data_pedido, valor_total
    from pedidos
    where status = p_status;
end //
delimiter ;

drop procedure if exists inserir_categoria;
delimiter //
create procedure inserir_categoria(
    in p_nome varchar(100),
    in p_descricao text
)
begin
    insert into categorias (nome, descricao)
    values (p_nome, p_descricao);
end //
delimiter ;

drop procedure if exists atualizar_telefone_cliente;
delimiter //
create procedure atualizar_telefone_cliente(
    in p_id_cliente int,
    in p_telefone varchar(15)
)
begin
    update clientes
    set telefone = p_telefone
    where id_cliente = p_id_cliente;
end //
delimiter ;

drop procedure if exists contar_produtos_categoria;
delimiter //
create procedure contar_produtos_categoria(
    in p_id_categoria int,
    out p_total int
)
begin
    select count(*)
    into p_total
    from produtos
    where id_categoria = p_id_categoria;
end //
delimiter ;

call listar_categorias_ativas();

call buscar_pedidos_por_status('pendente');

call contar_produtos_categoria(3, @total);
select @total as total_produtos;