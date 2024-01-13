CREATE TABLE Alumnos (
    Alumno_Id SERIAL PRIMARY KEY,
    Alumno_nombre VARCHAR(80),
    Alumno_ape1 VARCHAR(80),
    Alumno_ape2 VARCHAR(80),
    Alumno_Direccion VARCHAR(80),
    Alumno_Bootcamp INT
);

CREATE TABLE Profesores (
    Profesor_Id SERIAL PRIMARY KEY,
    Profesor_nombre VARCHAR(80),
    Profesor_ape1 VARCHAR(80),
    Profesor_ape2 VARCHAR(80),
    Profesor_Direccion VARCHAR(80)
);

CREATE TABLE BootCamps (
    Bootcamp_Id SERIAL PRIMARY KEY,
    BootCamp_Nombre VARCHAR(80),
    BootCamp_Precio VARCHAR(10),
    Bootcamp_Duracion INT
);

CREATE TABLE Bootcamp_Director (
	Bootcamp_Director_Id SERIAL PRIMARY KEY,
    Bootcamp_Id INT,
    Profesor_Id INT,
    FOREIGN KEY (Bootcamp_Id) REFERENCES BootCamps(Bootcamp_Id),
	FOREIGN KEY (Profesor_Id) REFERENCES Profesores(Profesor_Id)
);

CREATE TABLE Bootcamp_Profesor (
	Bootcamp_Profesor_Id SERIAL PRIMARY KEY,
    Bootcamp_Id INT,
    Profesor_Id INT,
    FOREIGN KEY (Bootcamp_Id) REFERENCES BootCamps(Bootcamp_Id),
	FOREIGN KEY (Profesor_Id) REFERENCES Profesores(Profesor_Id)
);

CREATE TABLE Modulos (
    Modulo_Id SERIAL PRIMARY KEY,
    Profesor_Id INT,
	Bootcamp_Id INT,
    Modulo_Duracion INT,
    Modulo_Tiene_Masterclass INT,
    Modulo_Tiene_Practicas INT,
	FOREIGN KEY (Profesor_Id) REFERENCES Profesores(Profesor_Id),
	FOREIGN KEY (Bootcamp_Id) REFERENCES BootCamps(Bootcamp_Id)
);

CREATE TABLE MasterClass (
    MasterClass_Id SERIAL PRIMARY KEY,
	Modulo_Id INT,
    Bootcamp_Id INT,
    MasterClass_Nombre VARCHAR(80),
    MasterClass_Clases INT,
	FOREIGN KEY (Modulo_Id) REFERENCES Modulos(Modulo_Id),
	FOREIGN KEY (Bootcamp_Id) REFERENCES BootCamps(Bootcamp_Id)
);

CREATE TABLE Practicas (
    Practica_Id SERIAL PRIMARY KEY,
    Practica_Nombre INT,
    Modulo_Id INT,
    Bootcamp_Id INT,
	FOREIGN KEY (Modulo_Id) REFERENCES Modulos(Modulo_Id),
	FOREIGN KEY (Bootcamp_Id) REFERENCES BootCamps(Bootcamp_Id)
);

CREATE TABLE Practica_Alumno (
    Practica_Alumno_Id SERIAL PRIMARY KEY,
    Practica_Id INT,
    Alumno_Id INT,
    Practica_Apto INT,
    Practica_Tiene_Reentrega INT,
    Practica_Fuera_Plazo INT,
    FOREIGN KEY (Practica_Id) REFERENCES Practicas(Practica_Id), FOREIGN KEY (Alumno_Id) REFERENCES Alumnos (Alumno_Id)
);