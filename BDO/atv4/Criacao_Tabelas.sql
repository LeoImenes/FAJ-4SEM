prompt PL/SQL Developer import file
prompt Created on segunda-feira, 27 de agosto de 2018 by Calderoni
set feedback off
set define off
prompt Criando Tabela ST_MODELO_DISPOSITIVO...
create table ST_MODELO_DISPOSITIVO
(
  ID_MODELO_DISPOSITIVO NUMBER not null,
  S_NOME                VARCHAR2(40) not null,
  S_ATIVO               VARCHAR2(1) default 'S' not null
);

alter table ST_MODELO_DISPOSITIVO add constraint XPKST_MODELO_DISPOSITIVO primary key (ID_MODELO_DISPOSITIVO);

prompt Criando Tabela ST_DISPOSITIVO...
create table ST_DISPOSITIVO
(
  ID_DISPOSITIVO        NUMBER not null,
  ID_MODELO_DISPOSITIVO NUMBER not null,
  S_NUMERO_SERIE        VARCHAR2(20) not null,
  S_ATIVO               VARCHAR2(1) default 'S' not null
);
alter table ST_DISPOSITIVO add constraint XPKST_DISPOSITIVO primary key (ID_DISPOSITIVO);
create unique index AK2_ST_DISPOSITIVO on ST_DISPOSITIVO (S_NUMERO_SERIE);

prompt Criando Tabela ST_EMPRESA...
create table ST_EMPRESA
(
  ID_EMPRESA NUMBER not null,
  S_NOME     VARCHAR2(20) not null,
  S_ATIVO    VARCHAR2(1) not null
);
alter table ST_EMPRESA  add constraint XPKST_EMPRESA primary key (ID_EMPRESA);

prompt Criando Tabela ST_DISPOSITIVO_EMPRESA...
create table ST_DISPOSITIVO_EMPRESA
(
  ID_DISPOSITIVO_EMPRESA NUMBER not null,
  ID_DISPOSITIVO         NUMBER not null,
  ID_EMPRESA             NUMBER not null,
  D_INICIO_USO           DATE not null,
  D_FIM_USO              DATE
);
alter table ST_DISPOSITIVO_EMPRESA add constraint XPKST_DISPOSITIVO_EMPRESA primary key (ID_DISPOSITIVO_EMPRESA);

prompt Criando Chaves Estrangeiras...
alter table ST_DISPOSITIVO add constraint FK_MOD_DISPOSITIVO foreign key (ID_MODELO_DISPOSITIVO) references ST_MODELO_DISPOSITIVO (ID_MODELO_DISPOSITIVO);
alter table ST_DISPOSITIVO_EMPRESA add constraint FK_DISPOSITIVO foreign key (ID_DISPOSITIVO) references ST_DISPOSITIVO (ID_DISPOSITIVO);
alter table ST_DISPOSITIVO_EMPRESA add constraint FK_EMPRESA foreign key (ID_EMPRESA) references ST_EMPRESA (ID_EMPRESA);

prompt Criando Comentários...
comment on table ST_MODELO_DISPOSITIVO is 'Tabela para armazenar os diversos Modelos de Dispositivos com os quais trabalhamos.';
comment on column ST_MODELO_DISPOSITIVO.ID_MODELO_DISPOSITIVO is 'Chave primária da tabela, formado por um número sequencial.';
comment on column ST_MODELO_DISPOSITIVO.S_NOME is 'Nome do modelo de dispositivo';
comment on column ST_MODELO_DISPOSITIVO.S_ATIVO is 'FLAG para indicar se um determinado modelo ainda está em uso (S) ou não (N).';

comment on table ST_DISPOSITIVO is 'Tabela para armazenar os diversos dispositivos pertencentes à Empresa';
comment on column ST_DISPOSITIVO.ID_DISPOSITIVO is 'Chave primária da tabela, formada por um número sequencial.';
comment on column ST_DISPOSITIVO.ID_MODELO_DISPOSITIVO is 'Chave estrangeira da tabela ST_MODELO_DISPOSITIVO e indica qual é o Modelo do Dispositivo';
comment on column ST_DISPOSITIVO.S_NUMERO_SERIE is 'Número de Série do Dispositivo. Não existem 2 dispositivos com mesmo Número de Série.';
comment on column ST_DISPOSITIVO.S_ATIVO is 'FLAG para indicar se um dispositivo está apto para USO (S) ou não (N). Os não aptos para uso indicam dispositivos quebrados, perdidos ou outras classificações que impedem o USO.';

comment on table ST_EMPRESA is 'Tabela para armazenar dados das diversas Empresas que são nossos clientes e para as quais alocamos dispositivos.';
comment on column ST_EMPRESA.ID_EMPRESA is 'Chave primária da tabela, formada por um número sequencial.';
comment on column ST_EMPRESA.S_NOME is 'Nome da Empresa.';
comment on column ST_EMPRESA.S_ATIVO is 'FLAG para indicar quais Empresas ainda são clientes Ativos (S) ou não fazem mais parte da carteira de Clientes (N).';

comment on table ST_DISPOSITIVO_EMPRESA is 'Tabela para armazenar o histórico de alocações de um determinado Dispositivo nas Empresas nas quais ele foi utilizado.';
comment on column ST_DISPOSITIVO_EMPRESA.ID_DISPOSITIVO_EMPRESA is 'Chave primária da tabela, formado por um número sequencial.';
comment on column ST_DISPOSITIVO_EMPRESA.ID_DISPOSITIVO is 'Chave estrangeira da tabela ST_DISPOSITIVO e indica qual é o Dispositivo aque está ou esteve locado.';
comment on column ST_DISPOSITIVO_EMPRESA.ID_EMPRESA is 'Chave estrangeira da tabela ST_EMPRESA e indica em qual Empresa o Dispositivo está ou esteve alocado.';
comment on column ST_DISPOSITIVO_EMPRESA.D_INICIO_USO is 'Data em que o Dispositivo foi alocado para a Empresa. Ou seja, a Data em que a Empresa passou a usar o Dispositivo.';
comment on column ST_DISPOSITIVO_EMPRESA.D_FIM_USO is 'Data em que o Dispositivo foi retirado da Empresa. Ou seja, a Data em que a Epresa parou de usar o Dispositivo e nos devolveu o mesmo. ATENÇÃO: caso esse campo esteja NULL, então significa que o dispositivo ainda está em uso pela Empresa!';

set feedback on
set define on
prompt Done.