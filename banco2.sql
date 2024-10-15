CREATE TABLE Usuarios 
( 
 id_usuario INT PRIMARY KEY AUTO_INCREMENT,  
 nome_usuario VARCHAR(255) NOT NULL,  
 email VARCHAR(255) NOT NULL UNIQUE,  
 senha VARCHAR(255) NOT NULL,  
 data_de_nascimento DATE,  
 cidade VARCHAR(255) NOT NULL,  
 estado VARCHAR(255) NOT NULL,  
 preferencia_musical VARCHAR(255),  
 ultimo_acesso DATE,
 CHECK (email LIKE '%_@__%.__%')  -- Verifica se o e-mail segue um formato básico
);

CREATE TABLE Artistas 
( 
 id_artista INT PRIMARY KEY AUTO_INCREMENT,  
 nome_artista VARCHAR(255) NOT NULL,  
 pais_origem VARCHAR(255) NOT NULL,  
 genero VARCHAR(255) NOT NULL,  
 ano_inicio INT NOT NULL,
 biografia VARCHAR(255),  
 email_artista VARCHAR(255) UNIQUE NOT NULL,
 CHECK (email_artista LIKE '%_@__%.__%'),  -- Valida o formato do e-mail
 CHECK (ano_inicio <= YEAR(CURDATE()))  -- Verifica se o ano de início não é maior que o ano atual
);

CREATE TABLE Pagamento 
( 
 id_pagamento INT PRIMARY KEY AUTO_INCREMENT,  
 meio_pagamento VARCHAR(255) NOT NULL,
 plano VARCHAR(255) NOT NULL,
 idUsuarios INT,
 FOREIGN KEY (idUsuarios) REFERENCES Usuarios(id_usuario),
 CHECK (meio_pagamento IN ('cartao_credito', 'debito', 'boleto')),  -- Meio de pagamento deve ser válido
 CHECK (plano IN ('Free', 'Premium', 'Family'))  -- Planos válidos
);

CREATE TABLE Albuns 
( 
 id_albuns INT PRIMARY KEY AUTO_INCREMENT,  
 nome_album VARCHAR(255) NOT NULL,  
 idArtistas INT,
 data_lancamento DATE NOT NULL,  
 genero_album VARCHAR(255),  
 num_faixas INT NOT NULL CHECK (num_faixas > 0),  -- Número de faixas deve ser positivo
 duracao_total VARCHAR(8) NOT NULL,  -- Pode seguir o formato 'HH:MM:SS'
 selo_gravadora VARCHAR(255),
 FOREIGN KEY (idArtistas) REFERENCES Artistas(id_artista)
);

CREATE TABLE Musicas 
( 
 id_musica INT PRIMARY KEY AUTO_INCREMENT,  
 nome_musica VARCHAR(255) NOT NULL,  
 idAlbuns INT,
 idArtistas INT,
 duracao VARCHAR(8) NOT NULL,  -- Formato de duração 'HH:MM:SS'
 num_reproducao INT NOT NULL CHECK (num_reproducao >= 0),  -- Número de reproduções não pode ser negativo
 linguagem VARCHAR(255), 
 FOREIGN KEY (idAlbuns) REFERENCES Albuns(id_albuns),
 FOREIGN KEY (idArtistas) REFERENCES Artistas(id_artista)
);

CREATE TABLE Playlists 
( 
 id_playlist INT PRIMARY KEY AUTO_INCREMENT,  
 nome_playlist VARCHAR(255) NOT NULL,  
 idUsuarios INT,
 idMusicas INT,
 data_criacao DATE NOT NULL,  
 duracao INT NOT NULL CHECK (duracao > 0),  -- Duração deve ser positiva
 FOREIGN KEY (idUsuarios) REFERENCES Usuarios(id_usuario),
 FOREIGN KEY (idMusicas) REFERENCES Musicas(id_musica),
 UNIQUE (nome_playlist, idUsuarios)  -- Nome da playlist deve ser único para cada usuário
);
