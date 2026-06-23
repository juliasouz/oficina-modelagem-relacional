CREATE TABLE IF NOT EXISTS `Cliente` (
	`idCliente` int AUTO_INCREMENT NOT NULL UNIQUE,
	`Nome` varchar(255) NOT NULL,
	`CPF_CNPJ` varchar(255) NOT NULL UNIQUE,
	`Telefone` varchar(255) NOT NULL,
	`Endereco` varchar(255) NOT NULL,
	PRIMARY KEY (`idCliente`)
);
CREATE TABLE IF NOT EXISTS `Equipe` (
	`idEquipe` int AUTO_INCREMENT NOT NULL UNIQUE,
	`Nome_Equipe` varchar(255) NOT NULL,
	PRIMARY KEY (`idEquipe`)
);
CREATE TABLE IF NOT EXISTS `Peca` (
	`idPeca` int AUTO_INCREMENT NOT NULL UNIQUE,
	`Descricao` varchar(255) NOT NULL,
	`Valor_Atual` decimal(10,2) NOT NULL,
	PRIMARY KEY (`idPeca`)
);
CREATE TABLE IF NOT EXISTS `Servico_Referencia` (
	`idServico` int AUTO_INCREMENT NOT NULL UNIQUE,
	`Descricao` varchar(255) NOT NULL,
	`Valor_Mao_Obra` decimal(10,2) NOT NULL,
	PRIMARY KEY (`idServico`)
);
CREATE TABLE IF NOT EXISTS `Veiculo` (
	`idVeiculo` int AUTO_INCREMENT NOT NULL UNIQUE,
	`idCliente` int NOT NULL,
	`Placa` varchar(255) NOT NULL UNIQUE,
	`Marca` varchar(255) NOT NULL,
	`Modelo` varchar(255) NOT NULL,
	`Ano` int NOT NULL,
	PRIMARY KEY (`idVeiculo`)
);
CREATE TABLE IF NOT EXISTS `Mecanico` (
	`idMecanico` int AUTO_INCREMENT NOT NULL UNIQUE,
	`idEquipe` int NOT NULL,
	`Nome` varchar(255) NOT NULL,
	`Endereco` varchar(255) NOT NULL,
	`Especialidade` varchar(255) NOT NULL,
	PRIMARY KEY (`idMecanico`)
);
CREATE TABLE IF NOT EXISTS `Ordem_Servico` (
	`idOS` int AUTO_INCREMENT NOT NULL UNIQUE,
	`idVeiculo` int NOT NULL,
	`idEquipe` int NOT NULL,
	`Data_Emissao` datetime NOT NULL,
	`Data_Conclusao_Prevista` datetime,
	`Data_Conclusao_Realizada` datetime,
	`Valor_Total` decimal(10,2) NOT NULL DEFAULT 0,
	`Status_OS` varchar(255) NOT NULL,
	PRIMARY KEY (`idOS`),
	CONSTRAINT `chk_status_os` CHECK (Status_OS IN ('ORCAMENTO', 'AGUARDANDO_APROVACAO', 'APROVADA', 'EM_EXECUCAO', 'CONCLUIDA', 'CANCELADA'))
);
CREATE TABLE IF NOT EXISTS `OS_Peca` (
	`idOS` int NOT NULL,
	`idPeca` int NOT NULL,
	`Quantidade` int NOT NULL DEFAULT 1,
	`Valor_Unitario` decimal(10,2) NOT NULL,
	CONSTRAINT `pk_os_peca` PRIMARY KEY (idOS, idPeca)
);
CREATE TABLE IF NOT EXISTS `OS_Servico` (
	`idOS` int NOT NULL,
	`idServico` int NOT NULL,
	`Valor_Cobrado` decimal(10,2) NOT NULL,
	CONSTRAINT `pk_os_servico` PRIMARY KEY (idOS, idServico)
);
ALTER TABLE `Veiculo` ADD CONSTRAINT `Veiculo_fk1` FOREIGN KEY (`idCliente`) REFERENCES `Cliente`(`idCliente`);
ALTER TABLE `Mecanico` ADD CONSTRAINT `Mecanico_fk1` FOREIGN KEY (`idEquipe`) REFERENCES `Equipe`(`idEquipe`);
ALTER TABLE `Ordem_Servico` ADD CONSTRAINT `Ordem_Servico_fk1` FOREIGN KEY (`idVeiculo`) REFERENCES `Veiculo`(`idVeiculo`);
ALTER TABLE `Ordem_Servico` ADD CONSTRAINT `Ordem_Servico_fk2` FOREIGN KEY (`idEquipe`) REFERENCES `Equipe`(`idEquipe`);
ALTER TABLE `OS_Peca` ADD CONSTRAINT `OS_Peca_fk0` FOREIGN KEY (`idOS`) REFERENCES `Ordem_Servico`(`idOS`);
ALTER TABLE `OS_Peca` ADD CONSTRAINT `OS_Peca_fk1` FOREIGN KEY (`idPeca`) REFERENCES `Peca`(`idPeca`);
ALTER TABLE `OS_Servico` ADD CONSTRAINT `OS_Servico_fk0` FOREIGN KEY (`idOS`) REFERENCES `Ordem_Servico`(`idOS`);
ALTER TABLE `OS_Servico` ADD CONSTRAINT `OS_Servico_fk1` FOREIGN KEY (`idServico`) REFERENCES `Servico_Referencia`(`idServico`);