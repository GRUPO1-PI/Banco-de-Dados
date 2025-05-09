CREATE DATABASE sonicorp;
use sonicorp;

CREATE TABLE empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    telefone VARCHAR(15) not null,
    dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    idEmpresa INT NOT NULL UNIQUE,
    logradouro VARCHAR(100) not null,
    numero INT not null,
    complemento VARCHAR(40), 
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


CREATE TABLE setor (
    idSetor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
		constraint chknome check (nome in ('Seleção de matéria prima','Higienização','Processamento','Embalagem','Armazenamento','Distribuição'))
);


CREATE TABLE esteira (
    idEsteira INT PRIMARY KEY AUTO_INCREMENT,
    idSetor INT, -- verificar a necessidade de uma coluna metragem.
    FOREIGN KEY (idSetor) REFERENCES setor(idSetor)
);



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


CREATE TABLE monitoramento (
    idMonitoramento INT AUTO_INCREMENT PRIMARY KEY,
    fkSensor INT,
    produtoDetectado BOOLEAN, -- Perguntar para a Vivian
    dtMonitoramento DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fkSensorMonit FOREIGN KEY (fkSensor)
        REFERENCES sensor(idSensor)
);