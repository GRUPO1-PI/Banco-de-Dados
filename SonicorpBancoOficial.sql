CREATE DATABASE sonicorp;
use sonicorp;

CREATE TABLE empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    telefone VARCHAR(15) not null,
    dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO empresa Values
(default, 'Alimentoz', '8919289237489', '11949692324', default);

CREATE TABLE endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    idEmpresa INT NOT NULL UNIQUE,
    logradouro VARCHAR(100) not null,
    numero INT not null,
    complemento VARCHAR(40), 
    bairro VARCHAR(100) not null,
    cidade VARCHAR(100) not null,
    UF CHAR(2) not null,
    cep CHAR(8) not null,
    FOREIGN KEY (idEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE representante (
    idRepresentante INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cpf CHAR(11) not null,
    telefone VARCHAR(15) not null,
    email VARCHAR(45) unique not null,
    senha VARCHAR(45) not null,
    idEmpresa INT,
    FOREIGN KEY (idEmpresa) REFERENCES empresa(idEmpresa)
);

insert into representante values
(default, 'Charles Xavier', '30550343054', '11997891312', 'xavier@email.com', 'BATATAS.', 1),
(default, 'Admin', '95853892395', '11984991395', 'admin3@admin.com', 'BATATAS.', 1);

CREATE TABLE setor (
    idSetor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
		constraint chknome check (nome in ('Seleção de matéria prima','Higienização','Processamento','Embalagem','Armazenamento','Distribuição')),
	fkEmpresa int,
		constraint fkEmpresa_setor foreign key (fkEmpresa) references empresa(idEmpresa)
);

insert into setor(nome, fkEmpresa) values
('Seleção de matéria prima', 1),
('Higienização', 1),
('Processamento', 1),
('Embalagem', 1),
('Armazenamento', 1),
('Distribuição', 1);


CREATE TABLE esteira (
    idEsteira INT PRIMARY KEY AUTO_INCREMENT,
    idSetor INT, -- verificar a necessidade de uma coluna metragem./ 4 sensores para cada esteira
    FOREIGN KEY (idSetor) REFERENCES setor(idSetor),
    numero INT,
    metragem INT
);

INSERT INTO esteira (idSetor, numero, metragem) VALUES
(1, 1, 8), (1, 2, 8), (1, 3, 8), (1, 4, 8), -- Seleção de matéria prima
(2, 1, 8), (2, 2, 8), (2, 3, 8), (2, 4, 8), -- Higienização
(3, 1, 8), (3, 2, 8), (3, 3, 8), (3, 4, 8), -- Processamento
(4, 1, 8), (4, 2, 8), (4, 3, 8), (4, 4, 8), -- Embalagem
(5, 1, 8), (5, 2, 8), (5, 3, 8), (5, 4, 8), -- Armazenamento
(6, 1, 8), (6, 2, 8), (6, 3, 8), (6, 4, 8); -- Distribuição

CREATE TABLE sensor (
    idSensor INT PRIMARY KEY auto_increment,
    numSerie CHAR(3),
    dtInstalacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkEsteira INT,
    CONSTRAINT fkSensor_Esteira
    FOREIGN KEY (fkEsteira)
    REFERENCES esteira(idEsteira),
    fkEmpresa INT, -- Verificar se é necessário pkComposta.
    CONSTRAINT fkSensor_empresa
    FOREIGN KEY (fkEmpresa)
    REFERENCES empresa(idEmpresa)
);

INSERT INTO sensor (numSerie, fkEsteira, fkEmpresa) VALUES
('A12', 1, 1), ('M12', 1, 1), ('C07', 1, 1), ('T16', 1, 1),
('B04', 2, 1), ('Z15', 2, 1), ('H11', 2, 1), ('R21', 2, 1),
('Y08', 3, 1), ('J19', 3, 1), ('D13', 3, 1), ('A02', 3, 1),
('G20', 4, 1), ('U06', 4, 1), ('N09', 4, 1), ('V18', 4, 1),
('L05', 5, 1), ('E14', 5, 1), ('P17', 5, 1), ('F22', 5, 1),
('S10', 6, 1), ('W03', 6, 1), ('K01', 6, 1), ('O07', 6, 1),
('I16', 7, 1), ('Q12', 7, 1), ('X02', 7, 1), ('M21', 7, 1),
('C19', 8, 1), ('T04', 8, 1), ('B09', 8, 1), ('Z22', 8, 1),
('H07', 9, 1), ('R13', 9, 1), ('Y20', 9, 1), ('J05', 9, 1),
('D16', 10, 1), ('G01', 10, 1), ('U08', 10, 1), ('M09', 10, 1),
('X14', 11, 1), ('A20', 11, 1), ('W17', 11, 1), ('L02', 11, 1),
('O04', 12, 1), ('K23', 12, 1), ('C06', 12, 1), ('S18', 12, 1),
('Y15', 13, 1), ('J02', 13, 1), ('D19', 13, 1), ('P08', 13, 1),
('B23', 14, 1), ('H04', 14, 1), ('N14', 14, 1), ('V07', 14, 1),
('F11', 15, 1), ('W22', 15, 1), ('T05', 15, 1), ('G18', 15, 1),
('X09', 16, 1), ('M14', 16, 1), ('C11', 16, 1), ('K07', 16, 1),
('E21', 17, 1), ('A03', 17, 1), ('L18', 17, 1), ('O12', 17, 1),
('J23', 18, 1), ('S02', 18, 1), ('N19', 18, 1), ('Q10', 18, 1),
('B12', 19, 1), ('U20', 19, 1), ('D05', 19, 1), ('V04', 19, 1),
('G22', 20, 1), ('T03', 20, 1), ('F19', 20, 1), ('W08', 20, 1),
('X13', 21, 1), ('M02', 21, 1), ('C20', 21, 1), ('K11', 21, 1),
('A19', 22, 1), ('Y06', 22, 1), ('L23', 22, 1), ('O10', 22, 1),
('J16', 23, 1), ('S21', 23, 1), ('D08', 23, 1), ('P14', 23, 1),
('B07', 24, 1), ('H20', 24, 1), ('N03', 24, 1), ('Q15', 24, 1);

select * from esteira;
SELECT COUNT(*) FROM esteira;
SELECT COUNT(*) FROM sensor;
SELECT fkEsteira, COUNT(*) FROM sensor GROUP BY fkEsteira;

CREATE TABLE registro (
    idRegistro INT AUTO_INCREMENT PRIMARY KEY,
    fkSensor INT,
    produtoDetectado BOOLEAN, -- Perguntar para a Vivian
    dtRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fkSensorRegis FOREIGN KEY (fkSensor)
        REFERENCES sensor(idSensor)
);

SELECT s.numSerie FROM sensor AS s JOIN esteira AS e ON
    s.fkEsteira = e.idEsteira WHERE s.fkEsteira = 7 AND e.idSetor = 4;