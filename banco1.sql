CREATE TABLE Usuarios 
( 
 id_usuario INT PRIMARY KEY,  
 nome_usuario VARCHAR(255),  
 email VARCHAR(255),  
 senha VARCHAR(255),  
 data_de_nascimento DATE,  
 cidade VARCHAR(255),  
 estado VARCHAR(255),  
 preferencia_musical VARCHAR(255),  
 ultimo_acesso DATE  
); 

CREATE TABLE Artistas 
( 
 id_artista INT PRIMARY KEY,  
 nome_artista VARCHAR(255),  
 pais_origem VARCHAR(255),  
 genero VARCHAR(255),  
 ano_inicio INT,  
 biografia VARCHAR(255),  
 email_artista VARCHAR(255)  
); 

CREATE TABLE Pagamento 
( 
 id_pagamento INT PRIMARY KEY,  
 meio_pagamento VARCHAR(255),  
 plano VARCHAR(255),  
 idUsuarios INT  
); 

CREATE TABLE Albuns 
( 
 id_albuns INT PRIMARY KEY,  
 nome_album VARCHAR(255),  
 idArtistas INT,  
 data_lancamento DATE,  
 genero_album VARCHAR(255),  
 num_faixas INT,  
 duracao_total VARCHAR(255),  
 selo_gravadora VARCHAR(255)  
); 

CREATE TABLE Musicas 
( 
 id_musica INT PRIMARY KEY,  
 nome_musica VARCHAR(255),  
 idAlbuns INT,  
 idArtistas INT,  
 duracao VARCHAR(255),  
 num_reproducao INT,  
 linguagem VARCHAR(255),  
 classificacao INT  
); 

CREATE TABLE Playlists 
( 
 id_playlist INT PRIMARY KEY,  
 nome_playlist VARCHAR(255),  
 idUsuarios INT,  
 idMusicas INT,  
 data_criacao DATE,  
 duracao INT  
); 

ALTER TABLE Pagamento ADD FOREIGN KEY(idUsuarios) REFERENCES Usuarios(idUsuarios);
ALTER TABLE Albuns ADD FOREIGN KEY(idArtistas) REFERENCES Artistas(idArtistas);
ALTER TABLE Musicas ADD FOREIGN KEY(idAlbuns) REFERENCES Albuns(idAlbuns);
ALTER TABLE Musicas ADD FOREIGN KEY(idArtistas) REFERENCES Artistas(idArtistas);
ALTER TABLE Playlists ADD FOREIGN KEY(idUsuarios) REFERENCES Usuarios(idUsuarios);
ALTER TABLE Playlists ADD FOREIGN KEY(idMusicas) REFERENCES Musicas(idMusicas);
