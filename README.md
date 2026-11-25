# Atividade: Consultas SQL e Stored Procedures (loja_tech)

Atividade prática de MySQL sobre o banco `loja_tech` (loja de tecnologia TechStore), dividida em duas partes: 10 consultas SQL e 5 stored procedures.

## Arquivos

| Arquivo | Função |
|---|---|
| `preparacao_loja_tech.sql` | Cria as 6 tabelas e insere os dados iniciais no banco `loja_tech`. Não contém `drop`. |
| `atividade_consultas_e_stored_procedures.sql` | Contém as 10 consultas e as 5 stored procedures da atividade. |
| `README.md` | Este documento. |

## Requisitos

- MySQL 8.0.13 ou superior (o script usa `default (current_user())` e a collation `utf8mb4_0900_ai_ci`).
- MySQL Workbench.
- Banco `loja_tech` já criado (`create database loja_tech;`).

## Ordem de execução

1. Abra o MySQL Workbench e conecte-se ao servidor.
2. Abra `preparacao_loja_tech.sql` (**File > Open SQL Script**) e execute tudo com o raio ⚡ sem nada selecionado. Execute **uma única vez**.
3. Confira o resultado esperado:

| tabela | registros |
|---|---|
| categorias | 5 |
| produtos | 11 |
| clientes | 5 |
| pedidos | 5 |
| itens_pedido | 7 |

4. Abra `atividade_consultas_e_stored_procedures.sql` e execute da mesma forma. As consultas exibem os resultados em abas separadas no **Result Grid**.

## Parte 1: Consultas SQL

| # | Descrição | Tabelas |
|---|---|---|
| 1 | Nome e e-mail de todos os clientes | `clientes` |
| 2 | Nome e preço dos produtos com preço menor que 500,00 | `produtos` |
| 3 | Todas as colunas dos pedidos com status `pendente` | `pedidos` |
| 4 | Nome e preço dos produtos, do mais caro ao mais barato | `produtos` |
| 5 | `id_produto`, nome e preço dos produtos que contêm "Monitor" no nome | `produtos` |
| 6 | Nome e estoque dos produtos da categoria 3 com mais de 40 unidades | `produtos` |
| 7 | Total de clientes (apelido `total_clientes`) | `clientes` |
| 8 | Soma de `valor_total` dos pedidos (apelido `faturamento_bruto`) | `pedidos` |
| 9 | `inner join` entre produtos e categorias (nome do produto e da categoria) | `produtos`, `categorias` |
| 10 | `inner join` com filtro: pedidos da cliente Ana Silva | `pedidos`, `clientes` |

## Parte 2: Stored Procedures

Todas seguem as boas práticas da aula: `drop procedure if exists`, `delimiter //` e prefixo `p_` nos parâmetros.

| # | Procedure | Parâmetros | O que faz |
|---|---|---|---|
| 1 | `listar_categorias_ativas` | nenhum | Lista `id_categoria`, `nome` e `descricao` das categorias ativas, em ordem alfabética |
| 2 | `buscar_pedidos_por_status` | `in p_status varchar(20)` | Lista `id_pedido`, `id_cliente`, `data_pedido` e `valor_total` dos pedidos com o status informado |
| 3 | `inserir_categoria` | `in p_nome varchar(100)`, `in p_descricao text` | Insere uma nova categoria |
| 4 | `atualizar_telefone_cliente` | `in p_id_cliente int`, `in p_telefone varchar(15)` | Atualiza o telefone do cliente informado |
| 5 | `contar_produtos_categoria` | `in p_id_categoria int`, `out p_total int` | Devolve a quantidade de produtos da categoria |

### Como chamar

```sql
call listar_categorias_ativas();
call buscar_pedidos_por_status('pendente');
call contar_produtos_categoria(3, @total);
select @total as total_produtos;
```

As chamadas de `inserir_categoria` e `atualizar_telefone_cliente` **não estão no arquivo**, porque modificam dados. Para testá-las, confira os registros antes e depois da chamada com um `select`.

## Observações

- **Exercício 5 da Parte 2 (inferência):** o enunciado do PDF termina em "quantidade total de produtos". A procedure conta **todos** os produtos da categoria informada, ativos ou não. Essa interpretação precisa ser confirmada com o enunciado completo.
- **Ordem do script:** os ids de categoria dependem da ordem dos `insert`. O exercício 6 da Parte 1 assume que `id_categoria = 3` é Periféricos.
- **Maiúsculas e minúsculas:** as palavras do SQL estão em minúsculo, mas os dados inseridos mantêm a grafia do material da aula (ex.: `'Ana Silva'`). A collation do banco ignora a diferença nas comparações.
- **Cuidado com o material da aula:** o script original começa com `drop database if exists loja_tech;`, que apaga o banco inteiro. Ele não foi usado aqui.
- **Status de validação:** nenhum código foi validado com evidência de execução até o momento. Um exercício só deve ser considerado concluído após ser executado e ter o resultado conferido.
