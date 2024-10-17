/* DDL */

CREATE TABLE tb_departamento(
    id INT8,
    nome VARCHAR(60),
    PRIMARY KEY(id)
);

CREATE TABLE tb_empregado(
    id INT8,
    nome VARCHAR(20),
    dept_id INT8,
    PRIMARY KEY(id),
    FOREIGN KEY(dept_id) REFERENCES tb_departamento(id)
);