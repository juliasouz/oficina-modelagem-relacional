# Arquitetura de Dados - Sistema de Oficina Mecânica

## Sobre o Projeto
Este repositório documenta a engenharia reversa e o desenho estrutural de uma base de dados relacional (OLTP) dedicada ao fluxo de trabalho de uma oficina mecânica. O diagrama reflete o ecossistema completo de gestão de clientes, veículos, atribuição de equipes técnicas e execução de ordens de serviço (OS).

## Lógica de Negócio e Governança
A modelagem foi desenhada focada na qualidade da informação na origem, o que é importante para sistemas transacionais:
* **Integridade Operacional:** As equipes agrupam os mecânicos e as ordens de serviço estão diretamente atreladas à equipe responsável e ao veículo do cliente.
* **Validação de Ciclo de Vida:** O campo `Status_OS` na entidade Ordem de Serviço possui restrições (*Check Constraints*) para garantir que a manutenção obedeça ao fluxo lógico ('ORCAMENTO', 'APROVADA', 'CONCLUIDA', etc).
* **Congelamento Histórico:** A arquitetura utiliza tabelas associativas (`OS_Peca` e `OS_Servico`) que registram o valor no exato momento da transação. Isso impede que atualizações no catálogo de preços alterem o histórico financeiro da operação passada.

## Artefatos do Repositório
* [Diagrama ER Oficina](/Oficina.png): Imagem gerada através do que foi realizado no DBDesigner com as relações entre as entidades.
<img width="1887" height="1585" alt="image" src="https://github.com/user-attachments/assets/474741a6-8e0e-4ef6-abdd-207994830640" />

* [Schema](/Oficina.sql): Código fonte na sintaxe DBML utilizado para renderizar o diagrama.
* [Documentação](/Documentacao_Oficina_DBML.pdf): Relatório técnico detalhado contendo a visão arquitetural e o código.
