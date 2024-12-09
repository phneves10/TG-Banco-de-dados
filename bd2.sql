-- 1. Generos
CREATE TABLE Generos (
    id_genero INT PRIMARY KEY AUTO_INCREMENT,
    nome_genero VARCHAR(50)
);

-- 2. Usuarios
CREATE TABLE Usuarios (
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

-- 3. Artistas
CREATE TABLE Artistas (
    id_artista INT PRIMARY KEY AUTO_INCREMENT,  
    nome_artista VARCHAR(255) NOT NULL,  
    pais_origem VARCHAR(255) NOT NULL,  
    genero VARCHAR(255) NOT NULL,  
    ano_inicio INT NOT NULL,
    biografia VARCHAR(255),  
    email_artista VARCHAR(255) UNIQUE NOT NULL
);

-- 4. Albuns
CREATE TABLE Albuns (
    id_albuns INT PRIMARY KEY AUTO_INCREMENT,  
    nome_album VARCHAR(255) NOT NULL,
    num_faixas INT,
    duracao_total TIME,
    idArtistas INT,
    data_lancamento DATE NOT NULL,  
    genero_album VARCHAR(255),  
    selo_gravadora VARCHAR(255),
    FOREIGN KEY (idArtistas) REFERENCES Artistas(id_artista)
);

-- 5. Musicas
CREATE TABLE Musicas (
    id_musica INT PRIMARY KEY AUTO_INCREMENT,
    id_genero INT,
    nome_musica VARCHAR(255) NOT NULL,
    duracao TIME,
    num_reproducao INT,
    idAlbuns INT,
    idArtistas INT,
    linguagem VARCHAR(255),
    FOREIGN KEY (id_genero) REFERENCES Generos(id_genero),
    FOREIGN KEY (idAlbuns) REFERENCES Albuns(id_albuns),
    FOREIGN KEY (idArtistas) REFERENCES Artistas(id_artista)
);

-- 6. Playlists
CREATE TABLE Playlists (
    id_playlist INT PRIMARY KEY AUTO_INCREMENT,  
    nome_playlist VARCHAR(255) NOT NULL,
    duracao TIME,
    idUsuarios INT,
    idMusicas INT,
    data_criacao DATE NOT NULL,  
    FOREIGN KEY (idUsuarios) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (idMusicas) REFERENCES Musicas(id_musica)
);

-- 7. Assinaturas
CREATE TABLE Assinaturas (
    id_assinatura INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    meio_pagamento VARCHAR(50), -- Débito, crédito, boleto.
    plano VARCHAR(50), -- Free, Premium, Family, etc.
    data_inicio DATE,
    data_fim DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 8. Favoritos
CREATE TABLE Favoritos (
    id_favoritos INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_musica INT,
    id_album INT,
    id_artista INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_musica) REFERENCES Musicas(id_musica),
    FOREIGN KEY (id_album) REFERENCES Albuns(id_albuns),
    FOREIGN KEY (id_artista) REFERENCES Artistas(id_artista)
);

-- 9. Avaliacao
CREATE TABLE Avaliacao (
    id_avaliacao INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_musica INT,
    id_album INT,
    id_artista INT,
    avaliacao INT CHECK (avaliacao >= 1 AND avaliacao <= 5), -- Avaliação entre 1 e 5
    data_avaliacao DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_musica) REFERENCES Musicas(id_musica),
    FOREIGN KEY (id_album) REFERENCES Albuns(id_albuns),
    FOREIGN KEY (id_artista) REFERENCES Artistas(id_artista)
);

-- 10. Seguidores
CREATE TABLE Seguidores (
    id_seguidores INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_artista INT,
    data_seguindo DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_artista) REFERENCES Artistas(id_artista)
);
