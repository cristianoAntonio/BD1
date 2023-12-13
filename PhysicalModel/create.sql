create database fazenda;

\c fazenda;

create table if not exists raca(
    codr integer not null,
    nome varchar(20) not null,
    descr varchar(50),
    constraint pk_raca primary key (codr)
);

create table if not exists animal(
    nbrinc integer not null,
    dtnasc date not null,
    codr integer not null,
    constraint pk_animal primary key (nbrinc),
    constraint fk_animal_raca foreign key (codr) references raca(codr)
);

create table if not exists lote(
    codl integer not null,
    dtini date not null,
    dtfim date not null,
    constraint pk_lote primary key (codl)
);

create table if not exists engorda(
    nbrinc integer not null,
    codl integer not null,
    day date not null,
    constraint pk_engorda primary key (nbrinc,codl,day),
    constraint fk_engorda_animal foreign key (nbrinc) references animal(nbrinc),
    constraint fk_engorda_lote foreign key (codl) references lote(codl)
);

create table if not exists doenca(
    codd integer not null,
    nome varchar(30) not null,
    descr varchar(50),
    constraint pk_doenca primary key (codd)
);

create table if not exists tratamento(
    nbrinc integer not null,
    codd integer not null,
    day date not null,
    constraint pk_tratamento primary key (nbrinc,codd,day),
    constraint fk_tratamento_animal foreign key (nbrinc) references animal(nbrinc),
    constraint fk_tratamento_doenca foreign key (codd) references doenca(codd)
);

create table if not exists obito(
    nbrinc integer not null,
    day date not null,
    constraint pk_obito primary key (nbrinc,day),
    constraint fk_obito_animal foreign key (nbrinc) references animal(nbrinc) 
);

create table if not exists tipoItem(
    codti integer not null,
    nome varchar(20) not null,
    descr varchar(50),
    constraint pk_tipoItem primary key (codti)
);

create table if not exists listaItem(
    codli integer not null,
    codti integer not null,
    valor integer not null,
    quant integer not null,
    constraint pk_listaItem primary key (codli),
    constraint fk_listaItem_tipoItem foreign key (codti) references tipoItem(codti)
);

create table if not exists despesa(
    codl integer not null,
    codli integer not null,
    day date not null,
    constraint pk_despesa primary key (codl,codli,day),
    constraint fk_despesa_listaItem foreign key (codli) references listaItem(codli),
    constraint fk_despesa_lote foreign key (codl) references lote(codl)
);

create table if not exists abate(
    coda integer not null,
    codl integer not null,
    precokg real not null,
    day date not null, 
    constraint pk_abate primary key (coda),
    constraint fk_abate_lote foreign key (codl) references lote(codl)
);

create table if not exists abatido(
    nbrinc integer not null,
    coda integer not null,
    peso integer not null,
    constraint pk_abatido primary key (nbrinc,coda),
    constraint fk_abatido_animal foreign key (nbrinc) references animal(nbrinc),
    constraint fk_abatido_abate foreign key (coda) references abate(coda)
);