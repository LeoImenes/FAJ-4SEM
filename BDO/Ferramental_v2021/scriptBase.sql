--------------------------------------------------
-- Export file for user INTERDISCIPLINAR        --
-- Created by Calderoni on 15/02/2012, 18:42:41 --
--------------------------------------------------

spool scriptBase.log

prompt
prompt Creating table FERRAMENTA
prompt =========================
prompt
create table FERRAMENTA
(
  ID_FERRAMENTA       NUMBER not null,
  S_NUMERO_PATRIMONIO VARCHAR2(50) not null,
  S_DESCRICAO         VARCHAR2(4000),
  D_DATA_COMPRA       DATE not null
)
;
comment on table FERRAMENTA
  is 'Tabela para armazenar as diversas ferramentas que dever�o er sua vida �til controlada pelo Sistema.';
comment on column FERRAMENTA.ID_FERRAMENTA
  is 'Identificador da Ferramenta. N�mero sequencial gerado automaticamente pelo Sistema.';
comment on column FERRAMENTA.S_NUMERO_PATRIMONIO
  is 'N�mero de Patrim�nio da Ferramenta.';
comment on column FERRAMENTA.S_DESCRICAO
  is 'Campo para descri��o detalhada da ferramenta.';
comment on column FERRAMENTA.D_DATA_COMPRA
  is 'Data de Cadastro da Ferramenta no Sistema. ';
alter table FERRAMENTA
  add constraint XPKFERRAMENTA primary key (ID_FERRAMENTA);
create unique index XAK1FERRAMENTA on FERRAMENTA (S_NUMERO_PATRIMONIO);

prompt
prompt Creating table FORNECEDOR
prompt =========================
prompt
create table FORNECEDOR
(
  S_NOME_FANTASIA VARCHAR2(120) not null,
  ID_FORNECEDOR   NUMBER not null,
  S_ATIVO         VARCHAR2(1) default 'S' not null,
  S_CNPJ          VARCHAR2(18) not null,
  S_RAZAO_SOCIAL  VARCHAR2(20) not null,
  S_ENDERECO      VARCHAR2(200) not null
)
;
comment on table FORNECEDOR
  is 'Tabela para armazenar os Fornecedores que ter�o suas entregas controladas pelo Sistema de Controle de Vida �til dasFerramentas.';
comment on column FORNECEDOR.S_NOME_FANTASIA
  is 'Nome Fantasia do Fornecedor.';
comment on column FORNECEDOR.ID_FORNECEDOR
  is 'Chave primaria da tabela, formado por um n�mero sequencial.';
comment on column FORNECEDOR.S_ATIVO
  is 'FLAG para indicar se o Fornecedor est� Ativo (S) ou Inativo (N). Apenas fornecedores cadastrados como ativos podem ser usados para cria��o de novas informa��es. Por padr�o assume o valor (S).';
comment on column FORNECEDOR.S_CNPJ
  is 'N�mero do CNPJ da Empresa, conforme cadastro no SAP.';
comment on column FORNECEDOR.S_RAZAO_SOCIAL
  is 'Raz�o Social do Fornecedor.';
comment on column FORNECEDOR.S_ENDERECO
  is 'Endere�o completo do Fornecedor.';
alter table FORNECEDOR
  add constraint XPKFORNECEDORES primary key (ID_FORNECEDOR);
alter table FORNECEDOR
  add constraint CK_FORNECEDOR_ATIVO
  check (S_ATIVO IN ('S', 'N'));
create unique index XAK1FORNECEDORES on FORNECEDOR (S_CNPJ);

prompt
prompt Creating table PECA
prompt ===================
prompt
create table PECA
(
  PART_NUMBER            VARCHAR2(30) not null,
  S_NOME                 VARCHAR2(128) not null,
  S_DESCRICAO_UTILIZACAO VARCHAR2(4000),
  S_ATIVO                VARCHAR2(1) not null,
  ID_PECA                NUMBER not null
)
;
comment on table PECA
  is 'Cadastro das pe�as que ter�o seus recebimentos controlados pelo sistema de Controle de Vida �til de Ferramentas.';
comment on column PECA.PART_NUMBER
  is 'Part-Number da Pe�a. Informa��o vinda do SAP.';
comment on column PECA.S_NOME
  is 'Nome ou descri��o da Pe�a, conforme cadastro no SAP.';
comment on column PECA.S_DESCRICAO_UTILIZACAO
  is 'Descri��o da utiliza��o da Pe�a.';
comment on column PECA.S_ATIVO
  is 'FLAG para indicar se a Pe�a est� Ativa (S) ou Inativa (N). Apenas Pe�as cadastradas como ativas podem ser usados para cria��o de novas informa��es. Por padr�o assume o valor (S).';
  comment on column PECA.ID_PECA
  is 'Chave primaria da tabela, formado por um n�mero sequencial.';
alter table PECA
  add constraint XPKPECA primary key (ID_PECA);
alter table PECA
  add constraint CK_PECA_ATIVO
  check (S_ATIVO IN ('S', 'N'));
create unique index XAK1PECA on PECA (PART_NUMBER);

prompt
prompt Creating table ALOCACAO_FERRAMENTA
prompt ==================================
prompt
create table ALOCACAO_FERRAMENTA
(
  ID_FORNECEDOR                 NUMBER not null,
  ID_FERRAMENTA                 NUMBER not null,
  ID_ALOCACAO_FERRAMENTA        NUMBER not null,
  N_CAPACIDADE_INICIAL_PRODUCAO NUMBER not null,
  D_INICIO_USO                  DATE not null,
  D_FIM_USO                     DATE,
  N_PORCENTAGEM_AVISO           NUMBER(2) not null,
  ID_PECA                       NUMBER not null
)
;
comment on table ALOCACAO_FERRAMENTA
  is 'Tabela contendo a Aloca��o de uma ferramenta em um determinado fornecedor produzindo determinada pe�a.';
comment on column ALOCACAO_FERRAMENTA.ID_FORNECEDOR
  is 'Chave estangeira da tabela FORNECEDOR e identifica qual � o Fornecedor que est� usando a Ferramenta alocada para produzir a pe�a especificada.';
comment on column ALOCACAO_FERRAMENTA.ID_FERRAMENTA
  is 'Chave estrangeira da Tabela FERRAMENTA e identifica qual � a Ferramenta alocada ao Fornecedor para produzir determinada Pe�a.';
comment on column ALOCACAO_FERRAMENTA.ID_ALOCACAO_FERRAMENTA
  is 'Identificador da Aloca��o de uma Ferramenta usada por um Fornecdor para produzir uma determinada Pe�a. N�mero sequencial criado automaticamente pelo Sistema.';
comment on column ALOCACAO_FERRAMENTA.N_CAPACIDADE_INICIAL_PRODUCAO
  is 'Capacidade inicial prevista para produ��o por essa aloca��o de ferramenta. Valor em N�mero de Pe�as.';
comment on column ALOCACAO_FERRAMENTA.D_INICIO_USO
  is 'Data de In�cio da Aloca��o no Fornecedor.';
comment on column ALOCACAO_FERRAMENTA.D_FIM_USO
  is 'Data Final de Uso da Aloca��o da Ferramenta no Fornecedor.';
comment on column ALOCACAO_FERRAMENTA.N_PORCENTAGEM_AVISO
  is 'Porcentagem de produ��o da ferramenta a partir da qual os usu�rios ser�o avisados que a vida �til da ferramenta est� terminando. O Valor padr�o, caso n�o se preencha a informa��o, ser� 70%.';
comment on column ALOCACAO_FERRAMENTA.ID_PECA
  is 'Chave estrangeira da tabela PECA e indica qual � a pe�a produzida pela Ferramenta no Fornecedor.';
alter table ALOCACAO_FERRAMENTA
  add constraint XPKALOCACAO_FERRAMENTA primary key (ID_ALOCACAO_FERRAMENTA);
alter table ALOCACAO_FERRAMENTA
  add constraint FK_FERRAMENTA_ALOCACAO_FERRAM foreign key (ID_FERRAMENTA)
  references FERRAMENTA (ID_FERRAMENTA);
alter table ALOCACAO_FERRAMENTA
  add constraint FK_FORNECEDOR_ALOCACAO_FERRAM foreign key (ID_FORNECEDOR)
  references FORNECEDOR (ID_FORNECEDOR);
alter table ALOCACAO_FERRAMENTA
  add constraint FK_PECA_ALOCACAO_FERRAMENTA foreign key (ID_PECA)
  references PECA (ID_PECA);

prompt
prompt Creating table ACRESCIMO_PRODUCAO
prompt =================================
prompt
create table ACRESCIMO_PRODUCAO
(
  ID_ACRESCIMO_PRODUCAO  NUMBER not null,
  ID_ALOCACAO_FERRAMENTA NUMBER not null,
  N_ACRESCIMO_PRODUCAO   NUMBER not null,
  D_DATA                 DATE not null,
  S_MOTIVO               VARCHAR2(127)
)
;
comment on table ACRESCIMO_PRODUCAO
  is 'Tabela para armazenar as altera��es efetuadas na Capacidade de Produ��o Inicial da aloca��o de uma Aloca��o de Ferramenta em um Fornecedor para produzir determinada pe�a.';
comment on column ACRESCIMO_PRODUCAO.ID_ACRESCIMO_PRODUCAO
  is 'Identificador do Acrescimo de Produ��o. N�mero sequencial gerado automaticamente pelo Sistema.';
comment on column ACRESCIMO_PRODUCAO.ID_ALOCACAO_FERRAMENTA
  is 'Chave estrangeira da tabela ALOCACAO_FERRAMENTA e identifica para qual Aloca��o e ferramenta foi feita o incremento na capacidade inicial da ferramenta.';
comment on column ACRESCIMO_PRODUCAO.N_ACRESCIMO_PRODUCAO
  is 'Valor do Incremento de produ��o, em n�mero de pe�as, a ser considerado para a aloca��o da ferramenta.';
comment on column ACRESCIMO_PRODUCAO.D_DATA
  is 'Data de cadastro do Incremento.';
comment on column ACRESCIMO_PRODUCAO.S_MOTIVO
  is 'Descri��o do Motivo do Incremento.';
alter table ACRESCIMO_PRODUCAO
  add constraint XPKACRESCIMO_PRODUCAO primary key (ID_ACRESCIMO_PRODUCAO);
alter table ACRESCIMO_PRODUCAO
  add constraint FK_ALOCA_FERRA_ACRESCIMO_PROD foreign key (ID_ALOCACAO_FERRAMENTA)
  references ALOCACAO_FERRAMENTA (ID_ALOCACAO_FERRAMENTA);

prompt
prompt Creating table RECEBIMENTO
prompt ==========================
prompt
create table RECEBIMENTO
(
  ID_RECEBIMENTO         NUMBER not null,
  D_DATA_RECEBIMENTO     DATE not null,
  N_QUANTIDADE_RECEBIDA  NUMBER not null,
  S_NOTA_FISCAL          VARCHAR2(10),
  ID_FORNECEDOR          NUMBER not null,
  ID_ALOCACAO_FERRAMENTA NUMBER not null,
  ID_PECA                NUMBER not null
)
;
comment on table RECEBIMENTO
  is 'Tabela para armazenar os recebimentos de Pe�as produzidas por um fornecedor usando um determinada ferramenta.';
comment on column RECEBIMENTO.ID_RECEBIMENTO
  is 'Identificador do Recebimento. N�mero sequencial gerado automaticamente pelo Sistema.';
comment on column RECEBIMENTO.D_DATA_RECEBIMENTO
  is 'Data do Recebimento.';
comment on column RECEBIMENTO.N_QUANTIDADE_RECEBIDA
  is 'Quantidade recebida.';
comment on column RECEBIMENTO.S_NOTA_FISCAL
  is 'N�mero da Nota Fiscal. Essa informa��o n�o ser� preenchida quando o recebimento for referente a um Scrap.';
comment on column RECEBIMENTO.ID_FORNECEDOR
  is 'Chave estrangeira da Tabela FORNECEDOR e identifica qual � Fornecedor envolvido no recebimento.';
comment on column RECEBIMENTO.ID_ALOCACAO_FERRAMENTA
  is 'Chave estrangeira da tabela ALOCACAO_FERRAMENTA e indica para qual aloca��o de Ferramenta dever� ser contabilizado o recebimento.';
comment on column RECEBIMENTO.ID_PECA
  is 'Chave estangeira da tabela PECA e indica qual a Pe�a que est� sendo recebida.';
alter table RECEBIMENTO
  add constraint XPKRECEBIMENTOS primary key (ID_RECEBIMENTO);
alter table RECEBIMENTO
  add constraint FK_ALOCACAO_FERRAMENTA_RECEBIM foreign key (ID_ALOCACAO_FERRAMENTA)
  references ALOCACAO_FERRAMENTA (ID_ALOCACAO_FERRAMENTA);
alter table RECEBIMENTO
  add constraint FK_FORNECEDOR_RECEBIMENTO foreign key (ID_FORNECEDOR)
  references FORNECEDOR (ID_FORNECEDOR);
alter table RECEBIMENTO
  add constraint FK_PECA_RECEBIMENTO foreign key (ID_PECA)
  references PECA (ID_PECA);
alter table RECEBIMENTO
  add constraint CK_QUANTIDADE_RECEBIDA
  check (N_QUANTIDADE_RECEBIDA  > 0);

prompt
prompt Creating table EMAIL_ENVIADO
prompt ==========================
prompt
create table EMAIL_ENVIADO
(
  HOST         varchar2(100) null,
  ORIGEM       varchar2(100) null,
  DESTINO      varchar2(100) null,
  TITULO       varchar2(100) null,
  MENSAGEM     varchar2(4000) null,
  DATA_ENVIO   date null);

spool off
