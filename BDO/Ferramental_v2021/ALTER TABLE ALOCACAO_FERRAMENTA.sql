ALTER TABLE ALOCACAO_FERRAMENTA
ADD CONSTRAINT check_porcentagem_aviso CHECK (N_PORCENTAGEM_AVISO  between 1 and 99); 

insert into ferramenta values (1,'23123','Parafuso','10/05/2022');
insert into fornecedor values ('Philips',1,'S','123312321','parafusos','Rua das Andorinhas');
insert into Peca values (1,'23123','Parafuso','10/05/2022');