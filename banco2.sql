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
 ultimo_acesso DATE
);

CREATE TABLE Artistas 
( 
 id_artista INT PRIMARY KEY AUTO_INCREMENT,  
 nome_artista VARCHAR(255) NOT NULL,  
 pais_origem VARCHAR(255) NOT NULL,  
 genero VARCHAR(255) NOT NULL,  
 ano_inicio INT NOT NULL,
 biografia VARCHAR(255),  
 email_artista VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE Pagamento 
( 
 id_pagamento INT PRIMARY KEY AUTO_INCREMENT,  
 meio_pagamento VARCHAR(255) NOT NULL,
 plano VARCHAR(255) NOT NULL,
 idUsuarios INT,
 FOREIGN KEY (idUsuarios) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Albuns 
( 
 id_albuns INT PRIMARY KEY AUTO_INCREMENT,  
 nome_album VARCHAR(255) NOT NULL,  
 idArtistas INT,
 data_lancamento DATE NOT NULL,  
 genero_album VARCHAR(255),  
 selo_gravadora VARCHAR(255),
 FOREIGN KEY (idArtistas) REFERENCES Artistas(id_artista)
);

CREATE TABLE Musicas 
( 
 id_musica INT PRIMARY KEY AUTO_INCREMENT,  
 nome_musica VARCHAR(255) NOT NULL,  
 idAlbuns INT,
 idArtistas INT,
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
 FOREIGN KEY (idUsuarios) REFERENCES Usuarios(id_usuario),
 FOREIGN KEY (idMusicas) REFERENCES Musicas(id_musica),
);
