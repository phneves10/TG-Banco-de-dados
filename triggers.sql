-- Trigger que verifica o e-mail do usuário, caso ele não esteja padronizado o banco retornará uma mensagem de erro

DELIMITER $$

CREATE TRIGGER VerificaEmailUsuarioInsert
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%_@__%.__%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de e-mail inválido.';
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER VerificaEmailUsuarioUpdate
BEFORE UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%_@__%.__%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de e-mail inválido.';
    END IF;
END$$

DELIMITER ;



-- Trigger que verifica as informações do artista, ela confere o formato do e-mail e o ano inserido.


DELIMITER $$

CREATE TRIGGER VerificaArtistaInsert
BEFORE INSERT ON Artistas
FOR EACH ROW
BEGIN
    -- Verifica se o e-mail tem um formato válido
    IF NEW.email_artista NOT LIKE '%_@__%.__%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de e-mail inválido.';
    END IF;

    -- Verifica se o ano de início não é maior que o ano atual
    IF NEW.ano_inicio > YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ano de início inválido. O ano de início não pode ser maior que o ano atual.';
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER VerificaArtistaUpdate
BEFORE UPDATE ON Artistas
FOR EACH ROW
BEGIN
    -- Verifica se o e-mail tem um formato válido
    IF NEW.email_artista NOT LIKE '%_@__%.__%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de e-mail inválido.';
    END IF;

    -- Verifica se o ano de início não é maior que o ano atual
    IF NEW.ano_inicio > YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ano de início inválido. O ano de início não pode ser maior que o ano atual.';
    END IF;
END$$

DELIMITER ;


-- Trigger criada para verificar os meios de pagamento, ela verifica se o meio de pagamento e plano são válidos


DELIMITER $$

CREATE TRIGGER VerificaPagamentoInsert
BEFORE INSERT ON Assinaturas
FOR EACH ROW
BEGIN
    -- Verifica se o meio de pagamento é válido
    IF NEW.meio_pagamento NOT IN ('Crédito', 'Débito', 'Boleto') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Meio de pagamento inválido. Escolha entre "cartao_credito", "debito" ou "boleto".';
    END IF;

    -- Verifica se o plano é válido
    IF NEW.plano NOT IN ('Free', 'Premium', 'Family') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Plano inválido. Escolha entre "Free", "Premium" ou "Family".';
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER VerificaPagamentoUpdate
BEFORE UPDATE ON Assinaturas
FOR EACH ROW
BEGIN
    -- Verifica se o meio de pagamento é válido
    IF NEW.meio_pagamento NOT IN ('Crédito', 'Débito', 'Boleto') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Meio de pagamento inválido. Escolha entre "cartao_credito", "debito" ou "boleto".';
    END IF;

    -- Verifica se o plano é válido
    IF NEW.plano NOT IN ('Free', 'Premium', 'Family') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Plano inválido. Escolha entre "Free", "Premium" ou "Family".';
    END IF;
END$$

DELIMITER ;


-- Sua função é verificar a tabela Albuns, esta trigger verifica se o número de faixas é maior do que 0, e se a duração total do album é valida


DELIMITER $$

CREATE TRIGGER VerificaAlbunsInsert
BEFORE INSERT ON Albuns
FOR EACH ROW
BEGIN
    -- Verifica se o número de faixas é positivo
    IF NEW.num_faixas <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Número de faixas inválido. Deve ser maior que 0.';
    END IF;

    -- Valida o formato da duração total (por exemplo, 'HH:MM:SS')
    IF NEW.duracao_total NOT REGEXP '^[0-9]{2}:[0-9]{2}:[0-9]{2}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de duração inválido. Use o formato HH:MM:SS.';
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER VerificaAlbunsUpdate
BEFORE UPDATE ON Albuns
FOR EACH ROW
BEGIN
    -- Verifica se o número de faixas é positivo
    IF NEW.num_faixas <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Número de faixas inválido. Deve ser maior que 0.';
    END IF;

    -- Valida o formato da duração total (por exemplo, 'HH:MM:SS')
    IF NEW.duracao_total NOT REGEXP '^[0-9]{2}:[0-9]{2}:[0-9]{2}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de duração inválido. Use o formato HH:MM:SS.';
    END IF;
END$$

DELIMITER ;


-- Esta trigger verifica a tabela musicas, sua função é bem parecida com a trigger "VerificaAlbuns", ela verifica se o 
-- número de reproduções é maior do que 0, e valida o formato de duração da música


DELIMITER $$

CREATE TRIGGER VerificaMusicasInsert
BEFORE INSERT ON Musicas
FOR EACH ROW
BEGIN
    -- Verifica se o número de reproduções é não-negativo
    IF NEW.num_reproducao < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Número de reproduções não pode ser negativo.';
    END IF;

    -- Valida o formato da duração (HH:MM:SS)
    IF NEW.duracao NOT REGEXP '^[0-9]{2}:[0-9]{2}:[0-9]{2}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de duração inválido. Use o formato HH:MM:SS.';
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER VerificaMusicasUpdate
BEFORE UPDATE ON Musicas
FOR EACH ROW
BEGIN
    -- Verifica se o número de reproduções é não-negativo
    IF NEW.num_reproducao < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Número de reproduções não pode ser negativo.';
    END IF;

    -- Valida o formato da duração (HH:MM:SS)
    IF NEW.duracao NOT REGEXP '^[0-9]{2}:[0-9]{2}:[0-9]{2}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de duração inválido. Use o formato HH:MM:SS.';
    END IF;
END$$

DELIMITER ;


-- Verifica a tabela playlist, ela confirma se a duração da playlist é maior do que 0, e verifica se o nome da playlist é único para cada usuário

DELIMITER $$

CREATE TRIGGER VerificaPlaylistsInsert
BEFORE INSERT ON Playlists
FOR EACH ROW
BEGIN
    -- Verifica se a duração é positiva
    IF NEW.duracao <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A duração deve ser positiva.';
    END IF;

    -- Verifica se o nome da playlist é único para cada usuário
    IF EXISTS (
        SELECT 1 FROM Playlists 
        WHERE nome_playlist = NEW.nome_playlist 
        AND idUsuarios = NEW.idUsuarios 
        AND id_playlist != NEW.id_playlist
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O usuário já tem uma playlist com esse nome.';
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER VerificaPlaylistsUpdate
BEFORE UPDATE ON Playlists
FOR EACH ROW
BEGIN
    -- Verifica se a duração é positiva
    IF NEW.duracao <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A duração deve ser positiva.';
    END IF;

    -- Verifica se o nome da playlist é único para cada usuário
    IF EXISTS (
        SELECT 1 FROM Playlists 
        WHERE nome_playlist = NEW.nome_playlist 
        AND idUsuarios = NEW.idUsuarios 
        AND id_playlist != NEW.id_playlist
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O usuário já tem uma playlist com esse nome.';
    END IF;
END$$

DELIMITER ;


-- Sua função é verificar a idade mínima na criação de novos usuários, caso o usuário tenha menos de 18 anos o sistema retornará uma mensagem de erro

DELIMITER $$

CREATE TRIGGER VerificaIdadeMinimaInsert
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    IF (TIMESTAMPDIFF(YEAR, NEW.data_de_nascimento, CURDATE()) < 18) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usuário deve ter pelo menos 18 anos.';
    END IF;
END$$

DELIMITER ;


-- Sua função é evitar músicas duplicadas na tabela músicas, caso a música já exista o sistema irá retornar uma mensagem de erro

DELIMITER $$

CREATE TRIGGER VerificaMusicaDuplicadaInsert
BEFORE INSERT ON Musicas
FOR EACH ROW
BEGIN
    DECLARE existe INT;
    SELECT COUNT(*) INTO existe
    FROM Musicas
    WHERE nome_musica = NEW.nome_musica AND idAlbuns = NEW.idAlbuns;

    IF existe > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Esta música já existe no álbum.';
    END IF;
END$$

DELIMITER ;

-- A função desta trigger é aplicar o SHA 256 nas novas senhas dos usuários, se trata de um método de criptografia de senhas

DELIMITER $$

CREATE TRIGGER BeforeInsertUsuario
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    SET NEW.senha = SHA2(NEW.senha, 256); -- Aplica SHA-256 na senha antes de inserir
END$$

DELIMITER ;
