CREATE DATABASE banco;
use banco;

 

create table conta(
    id int primary key auto_increment,
    saldo decimal(10,2) not null,
    tipoConta enum('C','P') not null
);

 

create table transferencia(
    id int primary key auto_increment,
    idContaOrigem int not null,
    idContaDestino int not null,
    valor decimal(10,2) not null,
    foreign key(idContaOrigem) references conta(id),
    foreign key(idContaDestino) references conta(id)
);

 

insert into conta values 
    (null, 2000, 'P'),(null, 1500, 'C'),
    (null, 200, 'P'),(null, 800, 'P'),
    (null, 1800, 'C'),(null, 1700, 'C'),
    (null, 200, 'C'),(null, 3000, 'P'),
    (null, 600, 'C'),(null, 1700, 'C'),
    (null, 600, 'P'),(null, 3000, 'P');
    
-- SP1
delimiter $$
create procedure verificaConta(IN idConta INT)
BEGIN
    SELECT if(tipoConta = 'P','Poupança','Corrente') as tipoConta from Conta 
    where id = idConta;
END $$
delimiter ;
call verificaConta(2);

 

delimiter $$
create procedure verificaConta2(IN idConta INT, OUT tpConta varchar(8))
BEGIN
    SELECT if(tipoConta = 'P','Poupança','Corrente') into tpConta from Conta 
    where id = idConta;
END $$
delimiter ;

 

call verificaConta(2);
set @tipoConta = '';
call verificaConta2(8,@tipoConta);
select @tipoConta;

 

-- -------------------------------------------------

 

-- SP2
delimiter $$
create procedure transferencia(IN valorTransf decimal(10,2), IN idContOrigem INT, IN idContDestino INT)
BEGIN
    update conta set saldo = saldo - valorTransf 
    where id = idContOrigem;
    update conta set saldo = saldo + valorTransf 
    where id = idContDestino;
    insert into transferencia values (null, idContOrigem, idContDestino, valorTransf);
END $$
delimiter ;

 

call transferencia (200, 5, 9);

 

delimiter $$
create procedure transferencia2(IN valorTransf decimal(10,2), IN idContOrigem INT, IN idContDestino INT)
BEGIN

 

    declare saldo1 decimal(10,2) default 0;
    
    select saldo into saldo1 from conta where id = idContOrigem;
    
    if(saldo1 > valorTransf)then
        update conta set saldo = saldo - valorTransf 
        where id = idContOrigem;
        update conta set saldo = saldo + valorTransf 
        where id = idContDestino;
        insert into transferencia values (null, idContOrigem, idContDestino, valorTransf);
    else
        select 'Saldo da conta insuficiente' as mensagem;
    end if;
END $$
delimiter ;

 

-- ---------------------------------------------------------------
-- SP3

 

delimiter $$
create procedure saque(IN idConta INT, IN valorSaque DECIMAL(10,2))
BEGIN
    update conta set saldo = saldo - valorSaque 
    where id = idConta;

 

END $$
DELIMITER ;

 

call saque(1,100);

 


delimiter $$
create procedure saque2(IN idConta INT, IN valorSaque DECIMAL(10,2))
BEGIN

 

    declare saldoSaque decimal(10,2) default 0;
    
    select saldo into saldoSaque from conta where id = idConta;
    if(saldoSaque > valorSaque) then
        update conta set saldo = saldo - valorSaque 
        where id = idConta;
    ELSE
        select 'Saldo da conta insuficiente' as mensagem;
    end if;
END $$
DELIMITER ;