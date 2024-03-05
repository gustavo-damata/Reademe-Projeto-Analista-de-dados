-- PARTE 1 - TRANSAÇÕES SEM PROCEDURE

-- Desabilitar o autocommit
SET autocommit = 0;

-- Iniciar a transação
START TRANSACTION;

-- Executar consultas e modificações de dados
UPDATE tabela SET coluna = valor WHERE condição;

-- Se tudo estiver OK, commitar a transação
COMMIT;

-- Se algo der errado, rollback da transação
ROLLBACK;

-- PARTE 2 - TRANSAÇÃO COM PROCEDURE

-- Criação da procedure
DELIMITER //

CREATE PROCEDURE MinhaProcedure()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Suas consultas e modificações de dados aqui
    UPDATE tabela SET coluna = valor WHERE condição;

    -- Se tudo estiver OK, commitar a transação
    COMMIT;
END //

DELIMITER ;

-- Chamar a procedure
CALL MinhaProcedure();

-- PARTE 3 - BACKUP E RECOVERY

-- Backup do banco de dados ecommerce
mysqldump -u usuario -p senha ecommerce > backup_ecommerce.sql;

-- Recovery do banco de dados ecommerce a partir do backup
mysql -u usuario -p senha ecommerce < backup_ecommerce.sql;
