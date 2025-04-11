USE sonicorp;

CREATE TABLE cadastroEmpresa (
	idCadastro INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	CNPJ CHAR(14),
	telefone VARCHAR(15),
	email VARCHAR(100),
	dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO cadastroEmpresa(nome, CNPJ, telefone, email) VALUES 
('TechNova Solutions', '12345678901234', '11987654321', 'contact@technova.com'),
('InovaMax Industries', '98765432109876', '11876543210', 'info@inovamax.com'),
('Fusion Corp', '56789012345678', '11765432109', 'support@fusioncorp.com'),
('NeonTech Ltda', '23456789012345', '11654321098', 'hello@neontech.com');

UPDATE cadastroEmpresa SET telefone = '11912345678', email = 'novocontato@technova.com' WHERE idCadastro = 1;
UPDATE cadastroEmpresa SET nome = 'TechNova Global', email = 'global@technova.com' WHERE idCadastro = 2;
UPDATE cadastroEmpresa SET telefone = '11987654322', CNPJ = '22334455667788' WHERE idCadastro = 3;
SELECT * FROM cadastroEmpresa;
SELECT nome, telefone FROM cadastroEmpresa WHERE CNPJ = '12345678901234';

DELETE FROM sensor WHERE idSensor = 3;


CREATE TABLE esteira (
	idEsteira INT PRIMARY KEY auto_increment,
	setor VARCHAR(45)
);

INSERT INTO esteira(setor) VALUES 
('Higienização'),
('Embalagem'),
('Processamento'),
('Distribuição');

UPDATE esteira SET setor = 'Seleção' WHERE idEsteira = 1;

UPDATE esteira SET setor = 'Armazenamento' WHERE idEsteira = 3;

UPDATE esteira SET setor = 'Embalagem' WHERE idEsteira = 4;

DELETE FROM esteira WHERE idEsteira = 3;

SELECT * FROM esteira;

SELECT setor FROM esteira WHERE idEsteira = 2;


CREATE TABLE sensor (
	idSensor INT PRIMARY KEY auto_increment,
	numSerie CHAR(3),
	dtInstalacao DATETIME DEFAULT CURRENT_TIMESTAMP,
	fkEsteira INT,
		CONSTRAINT fkSensor_Esteira
		FOREIGN KEY (fkEsteira)
		REFERENCES esteira(idEsteira),
	fkCadastro INT,
		CONSTRAINT fkSensor_Cadastro
		FOREIGN KEY (fkCadastro)
		REFERENCES cadastroEmpresa(idCadastro)
);
INSERT INTO sensor(numSerie, fkEsteira, fkCadastro) VALUES 
('A12', 1, 1),
('B34', 2, 2),
('C56', 3, 3),
('D78', 4, 4);

UPDATE sensor SET numSerie = 'X99' WHERE idSensor = 3;
SELECT * FROM sensor;

UPDATE sensor SET numSerie = 'Z01', fkEsteira = 2 WHERE idSensor = 1;

UPDATE sensor SET fkCadastro = 3 WHERE idSensor = 4;

SELECT numSerie, fkEsteira FROM sensor WHERE fkCadastro = 3;




CREATE TABLE monitoramento(
	idMonitoramento INT AUTO_INCREMENT,
	fkSensor INT,
		CONSTRAINT pkComposta PRIMARY KEY (idMonitoramento, fkSensor),
	alinhamento INT,
		CONSTRAINT chkalinhamento CHECK (alinhamento IN ('0', '1')),
	CONSTRAINT fkSensorMoni
	FOREIGN KEY (fkSensor)
	REFERENCES sensor(idSensor),
    dtMonitoramento DATETIME DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO monitoramento(fkSensor, alinhamento) VALUES 
(1, 1),
(2, 0),
(3, 1),
(4, 0);

UPDATE monitoramento SET alinhamento = 0 WHERE fkSensor = 3;
SELECT * FROM monitoramento;

UPDATE monitoramento SET alinhamento = 1 WHERE fkSensor = 2;

UPDATE monitoramento SET dtMonitoramento = '2025-04-07 16:30:00' WHERE fkSensor = 4;

DELETE FROM monitoramento WHERE fkSensor = 1 AND idMonitoramento = 1;

SELECT fkSensor, alinhamento FROM monitoramento WHERE alinhamento = 1;


 select s.numSerie AS Sensor, CASE WHEN m.alinhamento = 1 THEN 'Desalinhado' ELSE 'Alinhado' END AS Monitoramento,
 DATE_FORMAT(m.dtMonitoramento, '%d/%m/%Y %H:%i:%s') AS 'Data & Hora' FROM sensor AS s JOIN monitoramento AS m ON fkSensor = idSensor; 
 
 SELECT 
    c.nome AS Empresa,
    c.CNPJ,
    e.setor AS SetorEsteira,
    s.numSerie AS Sensor,
    CASE 
        WHEN m.alinhamento = 1 THEN 'Desalinhado' 
        ELSE 'Alinhado' 
    END AS Alinhamento,
    DATE_FORMAT(m.dtMonitoramento, '%d/%m/%Y %H:%i:%s') AS 'Data & Hora Monitoramento'
FROM monitoramento m
JOIN sensor s ON m.fkSensor = s.idSensor
JOIN esteira e ON s.fkEsteira = e.idEsteira
JOIN cadastroEmpresa c ON s.fkCadastro = c.idCadastro;
 
 
 
 


