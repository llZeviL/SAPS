DROP TABLE Preguntas_Frecuentes;
DROP TABLE Pregunta_Realizada;
DROP TABLE Solicitud_Realizada;
DROP TABLE Pregunta;
DROP TABLE Solicitud;
DROP TABLE Cursa_Ramo;
DROP TABLE Imparte_Ramo;
DROP TABLE Ramo;
DROP TABLE Estudiante;
DROP TABLE Director;
DROP TABLE Profesor;
DROP TABLE Secretaria;
DROP TABLE Carrera;
DROP TABLE Rol;

CREATE TABLE Rol(
    ID_Rol number not null,
    Nombre_Rol varchar2(30)
);

CREATE TABLE Carrera(
    ID_Carrera int not null,
    Nombre_Carrera varchar2(20)
);

CREATE TABLE Secretaria(
    ID_Secretaria number not null,
    Nombre_Secretaria varchar2(30),
	Email varchar2(40),
	Telefono number not null,
	Contrasenia varchar2(20),
    ID_Rol int not null
);

CREATE TABLE Profesor(
    ID_Profesor number not null,
    Nombre_Profesor varchar2(30),
	Email varchar2(40),
	Telefono number not null,
	Contrasenia varchar2(20),
    ID_Rol int not null
);

CREATE TABLE Director(
    ID_Director number not null,
    Nombre_Director varchar2(30),
	Email varchar2(40),
	Telefono number not null,
	Contrasenia varchar2(20),
    ID_Rol int not null,
    ID_Carrera int not null
);

CREATE TABLE Estudiante(
    ID_Estudiante number not null,
    Nombre_Estudiante varchar2(30),
	Email varchar2(40),
	Telefono number not null,
	Contrasenia varchar2(20),
    ID_Rol int not null,
    ID_Carrera int not null
);

CREATE TABLE Ramo(
    ID_Ramo int not null,
    Nombre_Ramo varchar2(20)
);

CREATE TABLE Imparte_Ramo(
    ID_Profesor number not null,
    ID_Ramo number not null
);

CREATE TABLE Cursa_Ramo(
    ID_Estudiante number not null,
    ID_Ramo number not null
);

CREATE TABLE Solicitud(    
    ID_Solicitud number not null,
    Prioridad varchar2(40),
    Contenido varchar2(200),
    Categoria varchar2(40),
    Fecha_Solicitud date
);

CREATE TABLE Pregunta(
    ID_Pregunta number not null,
    Prioridad varchar2(40),
    Contenido varchar2(200),
    Categoria varchar2(40),
    Destinatario varchar2(40),
    Fecha_Pregunta date
);

CREATE TABLE Solicitud_Realizada(
    Estado varchar2(20),
    Fecha_Solicitud date,
    ID_Solicitud int not null,
    ID_Estudiante number not null
);

CREATE TABLE Pregunta_Realizada(
    Estado varchar2(20),
    Fecha_Pregunta date,
    ID_Pregunta int not null,
    ID_Estudiante number not null
);

CREATE TABLE Preguntas_Frecuentes(
    ID_Preguntas_Frecuentes int not null,
    Titulo varchar2(20),
    Categoria varchar2(20),
    Contenido varchar2(300),
    ID_Carrera int not null
);

alter table Estudiante add constraint pk_Estudiante primary key (ID_Estudiante);
alter table Profesor add constraint pk_Profesor primary key (ID_Profesor);
alter table Director add constraint pk_Director primary key (ID_Director);
alter table Secretaria add constraint pk_Secretaria primary key (ID_Secretaria);
alter table Ramo add constraint pk_Ramo primary key (ID_Ramo);
alter table Cursa_Ramo add constraint pk_Cursa_Ramo primary key (ID_Estudiante, ID_Ramo);
alter table Imparte_Ramo add constraint pk_Imparte_Ramo primary key (ID_Profesor, ID_Ramo);
alter table Carrera add constraint pk_Carrera primary key (ID_Carrera);
alter table Pregunta add constraint pk_Pregunta primary key (ID_Pregunta);
alter table Pregunta_Realizada add constraint pk_Pregunta_Realizada primary key (ID_Estudiante, ID_Pregunta);
alter table Solicitud add constraint pk_Solicitud primary key (ID_Solicitud);
alter table Solicitud_Realizada add constraint pk_Solicitud_Realizada primary key (ID_Estudiante, ID_Solicitud);
alter table Preguntas_Frecuentes add constraint pk_Preguntas_Frecuentes primary key (ID_Preguntas_Frecuentes);
alter table Rol add constraint pk_Rol primary key (ID_Rol);

alter table Cursa_Ramo add constraint fk_Estudiante_Cursa foreign key(ID_Estudiante) references Estudiante(ID_Estudiante);
alter table Cursa_Ramo add constraint fk_Ramo_Cursa foreign key(ID_Ramo) references Ramo(ID_Ramo);
alter table Imparte_Ramo add constraint fk_Profesor_Imparte foreign key(ID_Profesor) references Profesor(ID_Profesor);
alter table Imparte_Ramo add constraint fk_Ramo_Imparte foreign key(ID_Ramo) references Ramo(ID_Ramo);
alter table Estudiante add constraint fk_Rol_1 foreign key(ID_Rol) references Rol(ID_Rol);
alter table Estudiante add constraint fk_Carrera_1 foreign key(ID_Carrera) references Carrera(ID_Carrera);
alter table Profesor add constraint fk_Rol_2 foreign key(ID_Rol) references Rol(ID_Rol);
alter table Director add constraint fk_Rol_3 foreign key(ID_Rol) references Rol(ID_Rol);
alter table Director add constraint fk_Carrera_2 foreign key(ID_Carrera) references Carrera(ID_Carrera);
alter table Secretaria add constraint fk_Rol_4 foreign key(ID_Rol) references Rol(ID_Rol);
alter table Pregunta_Realizada add constraint fk_Pregunta foreign key(ID_Pregunta) references Pregunta(ID_Pregunta);
alter table Solicitud_Realizada add constraint fk_Solicitud foreign key(ID_Solicitud) references Solicitud(ID_Solicitud);
alter table Pregunta_Realizada add constraint fk_Estudiante_2 foreign key(ID_Estudiante) references Estudiante(ID_Estudiante);
alter table Solicitud_Realizada add constraint fk_Estudiante_3 foreign key(ID_Estudiante) references Estudiante(ID_Estudiante);
alter table Preguntas_Frecuentes add constraint fk_Carrera_3 foreign key(ID_Carrera) references Carrera(ID_Carrera);

CREATE OR REPLACE PROCEDURE INSERTAR_Rol(
    ID_Rol_I IN Rol.ID_Rol%TYPE,
    Nombre_Rol_I IN ROL.Nombre_Rol%TYPE,
    MENSAJE OUT varchar2
)
IS 
    COMPROBAR_Rol number;
    Codigo_Existente EXCEPTION;
    
BEGIN
    LOCK TABLE Rol IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_ROL) INTO COMPROBAR_Rol FROM ROL WHERE ID_Rol_I=ID_Rol;

    IF COMPROBAR_Rol= 0 THEN
        INSERT INTO Rol VALUES(ID_ROL_I, Nombre_Rol_I);
        MENSAJE := 'Rol ingresado correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

    EXCEPTION
        WHEN Codigo_Existente THEN
            MENSAJE := 'El codigo del Rol ya existe';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM || ' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE INSERTAR_Carrera(
    ID_Carrera_I IN Carrera.ID_Carrera%TYPE,
    Nombre_Carrera_I IN Carrera.Nombre_Carrera%TYPE,
    MENSAJE OUT varchar2
)
IS
    COMPROBAR_Carrera number;
    Codigo_Existente EXCEPTION;
    
BEGIN
    LOCK TABLE Carrera IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Carrera) INTO COMPROBAR_Carrera FROM Carrera WHERE ID_Carrera_I = ID_Carrera;


    IF COMPROBAR_Carrera = 0 THEN
        INSERT INTO Carrera VALUES(ID_Carrera_I, Nombre_Carrera_I);
        MENSAJE := 'Carrera ingresada correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

    EXCEPTION
        WHEN Codigo_Existente THEN
            MENSAJE := 'El codigo de la Carrera ya existe';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE INSERTAR_Secretaria(
    ID_Secretaria_I IN Secretaria.ID_Secretaria%TYPE,
    Nombre_Secretaria_I IN Secretaria.Nombre_Secretaria%TYPE,
    Email_I IN Secretaria.Email%TYPE,
    Telefono_I IN Secretaria.Telefono%TYPE,
    Contrasenia_I IN Secretaria.Contrasenia%TYPE,
    ID_Rol_I IN Secretaria.ID_Rol%TYPE,
    MENSAJE OUT varchar2
)
IS 
    COMPROBAR_Secretaria number;
    Codigo_Existente EXCEPTION;
    
BEGIN
    LOCK TABLE Secretaria IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Secretaria) INTO COMPROBAR_Secretaria FROM Secretaria WHERE ID_Secretaria_I = ID_Secretaria;


    IF COMPROBAR_Secretaria = 0 THEN
        INSERT INTO Secretaria VALUES(ID_Secretaria_I, Nombre_Secretaria_I,Email_I, Telefono_I, Contrasenia_I, ID_Rol_I);
        MENSAJE := 'Secretaria ingresada correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

    EXCEPTION
        WHEN Codigo_Existente THEN
            MENSAJE := 'El codigo de la Secretaria ya existe';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM || ' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE INSERTAR_Profesor(
    ID_Profesor_I IN Profesor.ID_Profesor%TYPE,
    Nombre_Profesor_I IN Profesor.Nombre_Profesor%TYPE,
    Email_I IN Profesor.Email%TYPE,
    Telefono_I IN Profesor.Telefono%TYPE,
    Contrasenia_I IN Profesor.Contrasenia%TYPE,
    ID_Rol_I IN Profesor.ID_Rol%TYPE,
    MENSAJE OUT varchar2
)
IS
    COMPROBAR_Profesor number;
    Codigo_Existente EXCEPTION;
BEGIN

    LOCK TABLE Profesor IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Profesor) INTO COMPROBAR_Profesor FROM Profesor WHERE ID_Profesor_I = ID_Profesor;


    IF COMPROBAR_Profesor = 0 THEN
        INSERT INTO Profesor VALUES(ID_Profesor_I, Nombre_Profesor_I, Email_I, Telefono_I, Contrasenia_I, ID_Rol_I);
        MENSAJE := 'Profesor ingresado correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

    EXCEPTION
        WHEN Codigo_Existente THEN
            MENSAJE := 'El codigo del Profesor ya existe';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE INSERTAR_Director(
    ID_Director_I IN Director.ID_Director%TYPE,
    Nombre_Director_I IN Director.Nombre_Director%TYPE,
    Email_I IN Director.Email%TYPE,
    Telefono_I IN Director.Telefono%TYPE,
    Contrasenia_I IN Director.Contrasenia%TYPE,
    ID_Rol_I IN Director.ID_Rol%TYPE,
    ID_Carrera_I IN Director.ID_Carrera%TYPE,
    MENSAJE OUT varchar2
)
IS
    COMPROBAR_Director number;
    Codigo_Existente EXCEPTION;
    
BEGIN
    LOCK TABLE Director IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Director) INTO COMPROBAR_Director FROM Director WHERE ID_Director_I = ID_Director;


    IF COMPROBAR_Director = 0 THEN
        INSERT INTO Director VALUES(ID_Director_I, Nombre_Director_I, Email_I, Telefono_I, Contrasenia_I, ID_Rol_I, ID_Carrera_I);
        MENSAJE := 'Director ingresado correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

    EXCEPTION
        WHEN Codigo_Existente THEN
            MENSAJE := 'El codigo del Director ya existe';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE INSERTAR_Estudiante(
    ID_Estudiante_I IN Estudiante.ID_Estudiante%TYPE,
    Nombre_Estudiante_I IN Estudiante.Nombre_Estudiante%TYPE,
    Email_I IN Estudiante.Email%TYPE,
    Telefono_I IN Estudiante.Telefono%TYPE,
    Contrasenia_I IN Estudiante.Contrasenia%TYPE,
    ID_Rol_I IN Estudiante.ID_Rol%TYPE,
    ID_Carrera_I IN Estudiante.ID_Carrera%TYPE,
    MENSAJE OUT varchar2
)
Is 
    COMPROBAR_Estudiante number;
    Codigo_Existente EXCEPTION;
BEGIN

    LOCK TABLE Estudiante IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Estudiante) INTO COMPROBAR_Estudiante FROM Estudiante WHERE ID_Estudiante_I = ID_Estudiante;


    IF COMPROBAR_Estudiante = 0 THEN
        INSERT INTO Estudiante VALUES(ID_Estudiante_I, Nombre_estudiante_I,Email_I, Telefono_I, Contrasenia_I, ID_Rol_I, ID_Carrera_I);
        MENSAJE := 'Estudiante ingresado correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

    EXCEPTION
        WHEN Codigo_Existente THEN
            MENSAJE := 'El codigo del estudiante ya existe';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE INSERTAR_Ramo(
    ID_Ramo_I IN Ramo.ID_Ramo%TYPE,
    Nombre_Ramo_I IN Ramo.Nombre_Ramo%TYPE,
    MENSAJE OUT varchar2
)
IS
    COMPROBAR_Ramo number;
    Codigo_Existente EXCEPTION;
    
BEGIN
    LOCK TABLE Ramo IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Ramo) INTO COMPROBAR_Ramo FROM Ramo WHERE ID_Ramo_I = ID_Ramo;


    IF COMPROBAR_Ramo = 0 THEN
        INSERT INTO Ramo VALUES(ID_Ramo_I, Nombre_Ramo_I);
        MENSAJE := 'Ramo ingresado correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

    EXCEPTION
        WHEN Codigo_Existente THEN
            MENSAJE := 'El codigo del Ramo ya existe';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE INSERTAR_Imparte_Ramo(
    ID_Profesor_I IN Imparte_Ramo.ID_Profesor%TYPE,
    ID_Ramo_I IN Imparte_Ramo.ID_Ramo%TYPE,
    MENSAJE OUT varchar2
)
IS 
    COMPROBAR_Profesor number;
    COMPROBAR_Ramo number;
    Codigo_Existente EXCEPTION;
    
BEGIN
    LOCK TABLE Imparte_Ramo IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Profesor) INTO COMPROBAR_Profesor FROM Imparte_Ramo WHERE ID_Profesor_I = ID_Profesor;
    SELECT COUNT(ID_Ramo) INTO COMPROBAR_Ramo FROM Imparte_Ramo WHERE ID_Ramo_I = ID_Ramo;

    IF (COMPROBAR_Profesor>=0 and COMPROBAR_Ramo>=0) THEN
        INSERT INTO Imparte_Ramo VALUES(ID_Profesor_I, ID_Ramo_I);
        MENSAJE := 'Imparte_Ramo ingresado correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

EXCEPTION
    WHEN Codigo_Existente THEN
        MENSAJE := 'El codigo del curso impartido ya existe';
        ROLLBACK;
    WHEN OTHERS THEN
        MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM || ' - ' || SQLCODE;
        ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE INSERTAR_Cursa_Ramo(
    ID_Estudiante_I IN Cursa_Ramo.ID_Estudiante%TYPE,
    ID_Ramo_I IN Cursa_Ramo.ID_Ramo%TYPE,
    MENSAJE OUT varchar2
)
IS
    COMPROBAR_Estudiante number;
    COMPROBAR_Ramo number;
    Codigo_Existente EXCEPTION;
    
BEGIN
    LOCK TABLE Cursa_Ramo IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Estudiante) INTO COMPROBAR_Estudiante FROM Cursa_Ramo WHERE ID_Estudiante_I = ID_Estudiante;
    SELECT COUNT(ID_Ramo) INTO COMPROBAR_Ramo FROM Cursa_Ramo WHERE ID_Ramo_I = ID_Ramo;


    IF (COMPROBAR_Estudiante>=0 and COMPROBAR_Ramo>=0) THEN
        INSERT INTO Cursa_Ramo VALUES(ID_Estudiante_I, ID_Ramo_I);
        MENSAJE := 'Cursa_Ramo ingresado correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

    EXCEPTION
        WHEN Codigo_Existente THEN
            MENSAJE := 'El codigo del curso cursado ya existe';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM || ' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE INSERTAR_Solicitud(
    ID_Solicitud_I IN Solicitud.ID_Solicitud%TYPE,
    Prioridad_I IN Solicitud.Prioridad%TYPE,
    Contenido_I IN Solicitud.Contenido%TYPE,
    Categoria_I IN Solicitud.Categoria%TYPE,
    Fecha_solicitud_I IN Solicitud.Fecha_Solicitud%TYPE,
    MENSAJE OUT varchar2
)
IS 
    COMPROBAR_Solicitud number;
    Codigo_Existente EXCEPTION;
    
BEGIN
    LOCK TABLE Solicitud IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Solicitud) INTO COMPROBAR_Solicitud FROM Solicitud WHERE ID_Solicitud_I = ID_Solicitud;


    IF COMPROBAR_Solicitud = 0 THEN
        INSERT INTO Solicitud VALUES(ID_Solicitud_I, Prioridad_I, Contenido_I, Categoria_I, Fecha_solicitud_I);
        MENSAJE := 'Solicitud ingresado correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

    EXCEPTION
        WHEN Codigo_Existente THEN
            MENSAJE := 'El codigo de la Solicitud ya existe';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM || ' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE INSERTAR_Pregunta(
    ID_Pregunta_I IN Pregunta.ID_Pregunta%TYPE,
    Prioridad_I IN Pregunta.Prioridad%TYPE,
    Contenido_I IN Pregunta.Contenido%TYPE,
    Categoria_I IN Pregunta.Categoria%TYPE,
    Destinatario_I IN Pregunta.Destinatario%TYPE,
    Fecha_Pregunta_I IN Pregunta.Fecha_Pregunta%TYPE,
    MENSAJE OUT varchar2
)

IS
    COMPROBAR_Pregunta number;
    Codigo_Existente EXCEPTION;
BEGIN

    LOCK TABLE Pregunta IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Pregunta) INTO COMPROBAR_Pregunta FROM Pregunta WHERE ID_Pregunta_I = ID_Pregunta;


    IF COMPROBAR_Pregunta = 0 THEN
        INSERT INTO Pregunta VALUES(ID_Pregunta_I, Prioridad_I, Contenido_I, Categoria_I, Destinatario_I, Fecha_Pregunta_I);
        MENSAJE := 'Pregunta ingresada correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

    EXCEPTION
        WHEN Codigo_Existente THEN
            MENSAJE := 'El codigo de la Pregunta ya existe';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE INSERTAR_Solicitud_Realizada(
    Estado_I IN Solicitud_Realizada.Estado%TYPE,
    Fecha_solicitud_I IN Solicitud_Realizada.Fecha_Solicitud%TYPE,
    ID_Solicitud_I IN Solicitud_Realizada.ID_Solicitud%TYPE,
    ID_Estudiante_I IN Solicitud_Realizada.ID_Estudiante%TYPE,
    MENSAJE OUT varchar2
)
IS 
    COMPROBAR_Solicitud_Realizada number;
    COMPROBAR_ID_Estudiante number;
    Codigo_Existente EXCEPTION;
BEGIN

    LOCK TABLE Solicitud_Realizada IN ROW EXCLUSIVE MODE;
    SELECT COUNT (ID_Estudiante) INTO COMPROBAR_Solicitud_Realizada FROM Solicitud_Realizada WHERE ID_Estudiante_I = ID_Estudiante;
    SELECT COUNT (ID_Solicitud) INTO COMPROBAR_Solicitud_Realizada From Solicitud_Realizada WHERE ID_Solicitud_I = ID_Solicitud;

    IF (COMPROBAR_Solicitud_Realizada>= 0 and COMPROBAR_ID_Estudiante>=0) THEN
        INSERT INTO Solicitud_Realizada VALUES(Estado_I,Fecha_Solicitud_I, ID_Solicitud_I, ID_Estudiante_I);
        MENSAJE := 'Solicitud ingresada correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

    EXCEPTION
        WHEN Codigo_Existente THEN
            MENSAJE := 'El codigo de la Solicitud ya existe';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM || ' - ' || SQLCODE;
            ROLLBACK;
END;
    
CREATE OR REPLACE PROCEDURE INSERTAR_Pregunta_Realizada(
    Estado_I IN Pregunta_Realizada.Estado%TYPE,
    Fecha_Pregunta_I IN Pregunta_Realizada.Fecha_Pregunta%TYPE,
    ID_Pregunta_I IN Pregunta_Realizada.ID_Pregunta%TYPE,
    ID_Estudiante_I IN Pregunta_Realizada.ID_Estudiante%TYPE,
    MENSAJE OUT varchar2
)
    
IS
    COMPROBAR_Pregunta_Realizada number;
    COMPROBAR_ID_Estudiante number;
    Codigo_Existente EXCEPTION;
BEGIN

    LOCK TABLE Pregunta_Realizada IN ROW EXCLUSIVE MODE;
    SELECT COUNT (ID_Estudiante) INTO COMPROBAR_Pregunta_Realizada FROM Pregunta_Realizada WHERE ID_Estudiante_I = ID_Estudiante;
    SELECT COUNT (ID_Pregunta) INTO COMPROBAR_Pregunta_Realizada From Pregunta_Realizada WHERE ID_Pregunta_I = ID_Pregunta;


    IF (COMPROBAR_Pregunta_Realizada = 0 and COMPROBAR_ID_Estudiante = 0 )or (COMPROBAR_Pregunta_Realizada = 0 and COMPROBAR_ID_Estudiante > 0 ) or (COMPROBAR_Pregunta_Realizada > 0 and COMPROBAR_ID_Estudiante > 0 )THEN
        INSERT INTO Pregunta_Realizada VALUES( Estado_I, Fecha_Pregunta_I, ID_Pregunta_I, ID_Estudiante_I);
        MENSAJE := 'Pregunta Realizada ingresada correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

    EXCEPTION
        WHEN Codigo_Existente THEN
            MENSAJE := 'El codigo de la Pregunta Realizada ya existe';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE INSERTAR_Preguntas_Frecuentes(
    ID_Preguntas_Frecuentes_I IN Preguntas_Frecuentes.ID_Preguntas_Frecuentes%TYPE,
    Titulo_I IN Preguntas_Frecuentes.Titulo%TYPE,
    Categoria_I IN Preguntas_Frecuentes.Categoria%TYPE,
    Contenido_I IN Preguntas_Frecuentes.Contenido%TYPE,
    ID_Carrera_I IN Preguntas_Frecuentes.ID_Carrera%TYPE,
    MENSAJE OUT varchar2
)
IS 
    COMPROBAR_Preguntas_Frecuentes number;
    Codigo_Existente EXCEPTION;
BEGIN

    LOCK TABLE Preguntas_Frecuentes IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Preguntas_Frecuentes) INTO COMPROBAR_Preguntas_Frecuentes FROM Preguntas_Frecuentes WHERE ID_Preguntas_Frecuentes_I = ID_Preguntas_Frecuentes;


    IF COMPROBAR_Preguntas_Frecuentes = 0 THEN
        INSERT INTO Preguntas_Frecuentes VALUES(ID_Preguntas_Frecuentes_I,Titulo_I,Categoria_I,Contenido_I,ID_Carrera_I );
        MENSAJE := 'Solicitud ingresado correctamente';
        COMMIT;
    ELSE 
        RAISE Codigo_Existente;
    END IF;

    EXCEPTION
        WHEN Codigo_Existente THEN
            MENSAJE := 'El codigo de la pregunta frecuente ya existe';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM || ' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Rol(
    ID_Rol_I IN Rol.ID_Rol%TYPE,
    Mensaje OUT VARCHAR2
)
IS
    COMPROBAR_Rol NUMBER;
    Rol_No_Existe EXCEPTION;
 
BEGIN
    LOCK TABLE Rol IN ROW EXCLUSIVE MODE;
    SELECT COUNT (ID_Rol) INTO COMPROBAR_Rol FROM Rol WHERE ID_Rol_I = ID_Rol;
    
    IF COMPROBAR_Rol = 1 THEN
        DELETE FROM Rol WHERE ID_Rol_I = ID_Rol;
        Mensaje:= 'Rol eliminado Correctamente';
        COMMIT;
    ELSE
        RAISE Rol_No_Existe;
    END IF;
    
    EXCEPTION
        WHEN Rol_No_Existe THEN
            MENSAJE := 'El Rol no esta presente en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM || ' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Carrera(
    ID_Carrera_I IN Carrera.ID_Carrera%TYPE,
    MENSAJE OUT VARCHAR2
)
IS
    COMPROBAR_Carrera NUMBER;
    Carrera_No_Existe EXCEPTION;
 
BEGIN
    LOCK TABLE Carrera IN ROW EXCLUSIVE MODE;
    SELECT COUNT (ID_Carrera) INTO COMPROBAR_Carrera FROM Carrera WHERE ID_Carrera_I = ID_Carrera;
    
    IF COMPROBAR_Carrera = 1 THEN
        DELETE FROM Carrera WHERE ID_Carrera_I = ID_Carrera;
        MENSAJE:= 'Carrera eliminada Correctamente';
        COMMIT;
    ELSE
        RAISE Carrera_No_Existe;
    END IF;
    
    EXCEPTION
        WHEN Carrera_No_Existe THEN
            MENSAJE := 'La Carrera no esta presente en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos - '|| SQLERRM ||'-' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Secretaria(
    ID_Secretaria_I IN Secretaria.ID_Secretaria%TYPE,
    Mensaje OUT VARCHAR2
)
IS
    COMPROBAR_Secretaria NUMBER;
    Secretaria_No_Existe EXCEPTION;
 
BEGIN
    LOCK TABLE Secretaria IN ROW EXCLUSIVE MODE;
    SELECT COUNT (ID_Secretaria) INTO COMPROBAR_Secretaria FROM Secretaria WHERE ID_Secretaria_I = ID_Secretaria;
    
    IF COMPROBAR_Secretaria = 1 THEN
        DELETE FROM Secretaria WHERE ID_Secretaria_I = ID_Secretaria;
        Mensaje:= 'Secretaria eliminada Correctamente';
        COMMIT;
    ELSE
        RAISE Secretaria_No_Existe;
    END IF;
    
    EXCEPTION
        WHEN Secretaria_No_Existe THEN
            MENSAJE := 'La Secretaria no esta presente en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos - '|| SQLERRM ||'-'|| SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Profesor(
    ID_Profesor_I IN Profesor.ID_Profesor%TYPE,
    Mensaje OUT VARCHAR2
)
IS
    COMPROBAR_Profesor NUMBER;
    Profesor_No_Existe EXCEPTION;

BEGIN
    LOCK TABLE Profesor IN ROW EXCLUSIVE MODE;
    SELECT COUNT (ID_Profesor) INTO COMPROBAR_Profesor FROM Profesor WHERE ID_Profesor_I = ID_Profesor;
    
    IF COMPROBAR_Profesor = 1 THEN
        DELETE FROM Profesor WHERE ID_Profesor_I = ID_Profesor;
        Mensaje:= 'profes@r eliminad@ Correctamente';
        COMMIT;
    ELSE
        RAISE Profesor_No_Existe;
    END IF;
    
    EXCEPTION
        WHEN Profesor_No_Existe THEN
            MENSAJE := 'El/La profesor@ no esta presente en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos - '|| SQLERRM ||'-'|| SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Director(
    ID_Director_I IN Director.ID_Director%TYPE,
    Mensaje OUT VARCHAR2
)
IS
    COMPROBAR_Director NUMBER;
    Director_No_ExistE EXCEPTION;
 
BEGIN
    LOCK TABLE Director IN ROW EXCLUSIVE MODE;
    SELECT COUNT (ID_Director) INTO COMPROBAR_Director FROM Director WHERE ID_Director_I = ID_Director;
    
    IF COMPROBAR_Director = 1 THEN
        DELETE FROM Director WHERE ID_Director_I = ID_Director;
        Mensaje:= 'Director eliminado Correctamente';
        COMMIT;
    ELSE
        RAISE Director_No_Existe;
    END IF;
    
    EXCEPTION
        WHEN Director_No_Existe THEN
            MENSAJE := 'El Director no esta presente en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            Mensaje:= 'Ha ocurrido un error en la base de datos - '|| SQLERRM ||'-'|| SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Estudiante(
    ID_Estudiante_I IN Estudiante.ID_Estudiante%TYPE,
    MENSAJE OUT VARCHAR2
    )
IS
    COMPROBAR_Estudiante NUMBER;
    Estudiante_No_Existe EXCEPTION;
BEGIN
    LOCK TABLE Estudiante IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Estudiante) INTO COMPROBAR_Estudiante FROM Estudiante WHERE ID_Estudiante_I = ID_Estudiante;
 
    IF COMPROBAR_Estudiante = 1 THEN
        DELETE FROM Estudiante WHERE ID_Estudiante_I = ID_Estudiante;
        MENSAJE := 'Estudiante Eliminado Correctamente';
        COMMIT;
    ELSE
        RAISE Estudiante_No_Existe;
    END IF;
 
    EXCEPTION
        WHEN Estudiante_No_Existe THEN
            MENSAJE := 'La ID del Estudiante no existe en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE := 'Ha ocurrido un error en la base da datos -' || SQLERRM || ' - ' || SQLCODE;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Ramo(
    ID_Ramo_I IN Ramo.ID_Ramo%TYPE,
    Mensaje OUT VARCHAR2
)
IS
    COMPROBAR_Ramo NUMBER;
    Ramo_No_Existe EXCEPTION;
 
BEGIN
    LOCK TABLE Ramo IN ROW EXCLUSIVE MODE;
    SELECT COUNT (ID_Ramo) INTO COMPROBAR_Ramo FROM Ramo WHERE ID_Ramo_I = ID_Ramo;
    
    IF COMPROBAR_Ramo = 1 THEN
        DELETE FROM Ramo WHERE ID_Ramo_I = ID_Ramo;
        Mensaje:= 'Ramo eliminado Correctamente';
        COMMIT;
    ELSE
        RAISE Ramo_No_Existe;
    END IF;
    
    EXCEPTION
        WHEN Ramo_No_Existe THEN
            MENSAJE := 'El Ramo no esta presente en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos - '|| SQLERRM ||'-'|| SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Imparte_Ramo(
    ID_Profesor_I IN Imparte_Ramo.ID_Profesor%TYPE,
    ID_Ramo_I IN Imparte_Ramo.ID_Ramo%TYPE,
    Mensaje OUT VARCHAR2
)
IS
    COMPROBAR_Imparte_Ramo NUMBER;
    Imparte_Ramo_No_Existe EXCEPTION;
 
BEGIN
    LOCK TABLE Imparte_Ramo IN ROW EXCLUSIVE MODE;
    SELECT COUNT (ID_Profesor) INTO COMPROBAR_Imparte_Ramo FROM Imparte_Ramo WHERE ID_Profesor_I = ID_Profesor;
    SELECT COUNT (ID_Ramo) INTO COMPROBAR_Imparte_Ramo FROM Imparte_Ramo WHERE ID_Ramo_I = ID_Ramo;
    
    IF COMPROBAR_Imparte_Ramo = 1 THEN
        DELETE FROM Imparte_Ramo WHERE ID_Profesor_I = ID_Profesor and ID_Ramo_I = ID_Ramo;
        Mensaje:= 'Imparte_Ramo eliminado Correctamente';
        COMMIT;
    ELSE
        RAISE Imparte_Ramo_No_Existe;
    END IF;
    
    EXCEPTION
        WHEN Imparte_Ramo_No_Existe THEN
            MENSAJE := 'El Imparte_Ramo no esta presente en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos - '|| SQLERRM ||'-'|| SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Cursa_Ramo(
    ID_Estudiante_I IN Cursa_Ramo.ID_Estudiante%TYPE,
    ID_Ramo_I IN Cursa_Ramo.ID_Ramo%TYPE,
    Mensaje OUT VARCHAR2
)
IS
    COMPROBAR_Cursa_Ramo NUMBER;
    Cursa_Ramo_No_Existe EXCEPTION;
 
BEGIN
    LOCK TABLE Cursa_Ramo IN ROW EXCLUSIVE MODE;
    SELECT COUNT (ID_Estudiante) INTO COMPROBAR_Cursa_Ramo FROM Cursa_Ramo WHERE ID_Estudiante_I = ID_Estudiante;
    SELECT COUNT (ID_Ramo) INTO COMPROBAR_Cursa_Ramo FROM Cursa_Ramo WHERE ID_Ramo_I = ID_Ramo;
    
    IF COMPROBAR_Cursa_Ramo = 1 THEN
        DELETE FROM Cursa_Ramo WHERE ID_Ramo_I = ID_Ramo;
        Mensaje:= 'Cursa_Ramo eliminado Correctamente';
        COMMIT;
    ELSE
        RAISE Cursa_Ramo_No_Existe;
    END IF;
    
    EXCEPTION
        WHEN Cursa_Ramo_No_Existe THEN
            MENSAJE := 'El Cursa_Ramo no esta presente en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            Mensaje:= 'Ha ocurrido un error en la base de datos - '|| SQLERRM ||'-'|| SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Solicitud(
    ID_Solicitud_I IN Solicitud.ID_Solicitud%TYPE,
    MENSAJE OUT VARCHAR2
    )
IS
    COMPROBAR_Solicitud NUMBER;
    Solicitud_No_Existe EXCEPTION;
BEGIN
    LOCK TABLE Solicitud IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Solicitud) INTO COMPROBAR_Solicitud FROM Solicitud WHERE ID_Solicitud_I = ID_Solicitud;
 
    IF COMPROBAR_Solicitud = 1 THEN
        DELETE FROM Solicitud WHERE ID_Solicitud_I = ID_Solicitud;
        MENSAJE := 'Solicitud Eliminada Correctamente';
        COMMIT;
    ELSE
        RAISE Solicitud_No_Existe;
    END IF;
 
    EXCEPTION
        WHEN Solicitud_No_Existe THEN
            MENSAJE := 'La ID de la Solicitud no existe en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE := 'Ha ocurrido un error en la base da datos -' || SQLERRM || ' - ' || SQLCODE;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Pregunta(
    ID_Pregunta_I IN Pregunta.ID_Pregunta%TYPE,
    MENSAJE OUT VARCHAR2
    )
IS
    COMPROBAR_Pregunta NUMBER;
    Pregunta_No_Existe EXCEPTION;
BEGIN
    LOCK TABLE Pregunta IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Pregunta) INTO COMPROBAR_Pregunta FROM Pregunta WHERE ID_Pregunta_I = ID_Pregunta;
 
    IF COMPROBAR_Pregunta = 1 THEN
        DELETE FROM Pregunta WHERE ID_Pregunta_I = ID_Pregunta;
        MENSAJE := 'Pregunta Eliminada Correctamente';
        COMMIT;
    ELSE
        RAISE Pregunta_No_Existe;
    END IF;
 
    EXCEPTION
        WHEN Pregunta_No_Existe THEN
            MENSAJE := 'La ID de la Pregunta no existe en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE := 'Ha ocurrido un error en la base da datos -' || SQLERRM || ' - ' || SQLCODE;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Solicitud_Realizada(
    ID_Solicitud_I IN Solicitud_Realizada.ID_Solicitud%TYPE,
    ID_Estudiante_I IN Solicitud_Realizada.ID_Estudiante%TYPE,
    MENSAJE OUT VARCHAR2
    )
IS
    COMPROBAR_Solicitud_Realizada NUMBER;
    Solicitud_Realizada_No_Existe EXCEPTION;
    
BEGIN
    LOCK TABLE Solicitud_Realizada IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Solicitud) INTO COMPROBAR_Solicitud_Realizada FROM Solicitud_Realizada WHERE ID_Solicitud_I = ID_Solicitud;
    SELECT COUNT(ID_Estudiante) INTO COMPROBAR_Solicitud_Realizada FROM Solicitud_Realizada WHERE ID_Estudiante_I = ID_Estudiante;
 
    IF COMPROBAR_Solicitud_Realizada = 1 THEN
        DELETE FROM Solicitud_Realizada WHERE ID_Solicitud_I = ID_Solicitud and ID_Estudiante_I = ID_Estudiante;
        MENSAJE := 'Solicitud Realizada Eliminada Correctamente';
        COMMIT;
    ELSE
        RAISE Solicitud_Realizada_No_Existe;
    END IF;
 
    EXCEPTION
        WHEN Solicitud_Realizada_No_Existe THEN
            MENSAJE := 'La ID de la Solicitud Realizada no existe en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE := 'Ha ocurrido un error en la base da datos -' || SQLERRM || ' - ' || SQLCODE;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Pregunta_Realizada(
    ID_Pregunta_I IN Pregunta_Realizada.ID_Pregunta%TYPE,
    ID_Estudiante_I IN Pregunta_Realizada.ID_Estudiante%TYPE,
    MENSAJE OUT VARCHAR2
    )
IS
    COMPROBAR_Pregunta_Realizada NUMBER;
    Pregunta_Realizada_No_Existe EXCEPTION;
BEGIN
    LOCK TABLE Pregunta_Realizada IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Pregunta) INTO COMPROBAR_Pregunta_Realizada FROM Pregunta_Realizada WHERE ID_Pregunta_I = ID_Pregunta;
 
    IF COMPROBAR_Pregunta_Realizada = 1 THEN
        DELETE FROM Pregunta_Realizada WHERE ID_Pregunta_I = ID_Pregunta and ID_Estudiante_I = ID_Estudiante;
        MENSAJE := 'Pregunta Realizada Eliminada Correctamente';
        COMMIT;
    ELSE
        RAISE Pregunta_Realizada_No_Existe;
    END IF;
 
    EXCEPTION
        WHEN Pregunta_Realizada_No_Existe THEN
            MENSAJE := 'La ID de la pregunta Realizada no existe en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE := 'Ha ocurrido un error en la base da datos -' || SQLERRM || ' - ' || SQLCODE;
END;

CREATE OR REPLACE PROCEDURE ELIMINAR_Preguntas_Frecuentes(
    ID_Preguntas_Frecuentes_I IN Preguntas_Frecuentes.ID_Preguntas_Frecuentes%TYPE,
    MENSAJE OUT VARCHAR2
    )
IS
    COMPROBAR_Preguntas_Frecuentes NUMBER;
    Pregunta_Frecuente_No_Existe EXCEPTION;
BEGIN
    LOCK TABLE Preguntas_Frecuentes IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Preguntas_Frecuentes) INTO COMPROBAR_Preguntas_Frecuentes FROM Preguntas_Frecuentes WHERE ID_Preguntas_Frecuentes_I = ID_Preguntas_Frecuentes;
 
    IF COMPROBAR_Preguntas_Frecuentes = 1 THEN
        DELETE FROM Preguntas_Frecuentes WHERE ID_Preguntas_Frecuentes_I = ID_Preguntas_Frecuentes;
        MENSAJE := 'Pregunta Frecuente Eliminada Correctamente';
        COMMIT;
    ELSE
        RAISE Pregunta_Frecuente_No_Existe;
    END IF;
 
    EXCEPTION
        WHEN Pregunta_Frecuente_No_Existe THEN
            MENSAJE := 'La ID de la pregunta frecuente no existe en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE := 'Ha ocurrido un error en la base de datos -' || SQLERRM || ' - ' || SQLCODE;
END;

CREATE OR REPLACE PROCEDURE ACTUALIZAR_Rol(
    ID_Rol_I IN Rol.ID_Rol%TYPE,
    Nombre_Rol_I IN ROL.Nombre_Rol%TYPE,
    MENSAJE OUT varchar2
)
Is
    COMPROBAR_Rol number;
    Rol_No_Existente EXCEPTION;
BEGIN
    LOCK TABLE Rol IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Rol) INTO COMPROBAR_Rol FROM ROL WHERE ID_Rol_I=ID_Rol;
 
    IF COMPROBAR_Rol= 1 THEN
        UPDATE Rol
        SET  Nombre_Rol = Nombre_Rol_I
        WHERE ID_Rol = ID_Rol_I;
        MENSAJE := 'Rol Actualizado correctamente';
        COMMIT;
    ELSE
        RAISE Rol_No_Existente;
    END IF;
 
    EXCEPTION
        WHEN Rol_No_Existente THEN
            MENSAJE := 'El codigo del Rol no se encuentra en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM || ' - ' || SQLCODE;
            ROLLBACK;
END;

 CREATE OR REPLACE PROCEDURE ACTUALIZAR_Carrera(
    ID_Carrera_I IN Carrera.ID_Carrera%TYPE,
    Nombre_Carrera_I IN Carrera.Nombre_Carrera%TYPE,
    MENSAJE OUT varchar2
)
IS
    COMPROBAR_Carrera number;
    Carrera_No_Existente EXCEPTION;
BEGIN
 
    LOCK TABLE Carrera IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Carrera) INTO COMPROBAR_Carrera FROM Carrera WHERE ID_Carrera_I = ID_Carrera;
 
 
    IF COMPROBAR_Carrera = 1 THEN
        UPDATE Carrera
        SET Nombre_Carrera = Nombre_Carrera_I
        WHERE ID_Carrera = ID_Carrera_I;
        MENSAJE := 'Carrera Actualizada correctamente';
        COMMIT;
    ELSE
        RAISE Carrera_No_Existente;
    END IF;
 
    EXCEPTION
        WHEN Carrera_No_Existente THEN
            MENSAJE := 'El codigo de la Carrera no se encuentra en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ACTUALIZAR_Secretaria(
    ID_Secretaria_I IN Secretaria.ID_Secretaria%TYPE,
    Nombre_Secretaria_I IN Secretaria.Nombre_Secretaria%TYPE,
    Email_I IN Secretaria.Email%TYPE,
    Telefono_I IN Secretaria.Telefono%TYPE,
    Contrasenia_I IN Secretaria.Contrasenia%TYPE,
    ID_Rol_I IN Secretaria.ID_Rol%TYPE,
    MENSAJE OUT varchar2
)
Is
    COMPROBAR_Secretaria number;
    Secretaria_No_Existente EXCEPTION;
BEGIN
 
    LOCK TABLE Secretaria IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Secretaria) INTO COMPROBAR_Secretaria FROM Secretaria WHERE ID_Secretaria_I = ID_Secretaria;
 
 
    IF COMPROBAR_Secretaria = 1 THEN
        UPDATE Secretaria
        SET Nombre_Secretaria = Nombre_Secretaria_I, Email = Email_I, Telefono = Telefono_I, Contrasenia = Contrasenia_I, ID_Rol = ID_Rol_I
        WHERE ID_Secretaria = ID_Secretaria_I;
        MENSAJE := 'Secretaria Actualizada correctamente';
        COMMIT;
    ELSE
        RAISE Secretaria_No_Existente;
    END IF;
 
    EXCEPTION
        WHEN Secretaria_No_Existente THEN
            MENSAJE := 'El codigo de la Secretaria no se encuentra en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM || ' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE Actualizar_Profesor(
    ID_Profesor_I IN Profesor.ID_Profesor%TYPE,
    Nombre_Profesor_I IN Profesor.Nombre_Profesor%TYPE,
    Email_I IN Profesor.Email%TYPE,
    Telefono_I IN Profesor.Telefono%TYPE,
    Contrasenia_I IN Profesor.Contrasenia%TYPE,
    ID_Rol_I IN Profesor.ID_Rol%TYPE,
    MENSAJE OUT varchar2
)
IS
    COMPROBAR_Profesor number;
    Profesor_No_Existente EXCEPTION;
BEGIN
 
    LOCK TABLE Profesor IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Profesor) INTO COMPROBAR_Profesor FROM Profesor WHERE ID_Profesor_I = ID_Profesor;
 
 
    IF COMPROBAR_Profesor = 1 THEN
        UPDATE Profesor
        SET Nombre_Profesor = Nombre_Profesor_I , Email = Email_I, Telefono = Telefono_I, Contrasenia = Contrasenia_I , ID_Rol = ID_Rol_I
        WHERE ID_Profesor = ID_Profesor_I;
        MENSAJE := 'Profesor Actualizado correctamente';
        COMMIT;
    ELSE
        RAISE Profesor_No_Existente;
    END IF;
 
    EXCEPTION
        WHEN Profesor_No_Existente THEN
            MENSAJE := 'El codigo del Profesor no se encuentra en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ACTUALIZAR_Director(
    ID_Director_I IN Director.ID_Director%TYPE,
    Nombre_Director_I IN Director.Nombre_Director%TYPE,
    Email_I IN Director.Email%TYPE,
    Telefono_I IN Director.Telefono%TYPE,
    Contrasenia_I IN Director.Contrasenia%TYPE,
    ID_Rol_I IN Director.ID_Rol%TYPE,
    ID_Carrera_I IN Director.ID_Carrera%TYPE,
    MENSAJE OUT varchar2
)
IS
    COMPROBAR_Director number;
    Director_No_Existente EXCEPTION;
BEGIN
 
    LOCK TABLE Director IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Director) INTO COMPROBAR_Director FROM Director WHERE ID_Director_I = ID_Director;
 
 
    IF COMPROBAR_Director = 1 THEN
        UPDATE Director
        SET Nombre_Director = Nombre_Director_I , Email = Email_I , Telefono = Telefono_I, Contrasenia = Contrasenia_I,ID_Rol = ID_Rol_I , ID_Carrera = ID_Carrera_I
        WHERE ID_Director = ID_Director_I;
        MENSAJE := 'Director Actualizado correctamente';
        COMMIT;
    ELSE
        RAISE Director_No_Existente;
    END IF;
 
    EXCEPTION
        WHEN Director_No_Existente THEN
            MENSAJE := 'El codigo del Director no se encuentra en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE Actualizar_Estudiante(
    ID_Estudiante_I IN Estudiante.ID_Estudiante%TYPE,
    Nombre_estudiante_I IN Estudiante.Nombre_estudiante%TYPE,
    Email_I IN Estudiante.Email%TYPE,
    Telefono_I IN Estudiante.Telefono%TYPE,
    Contrasenia_I IN Estudiante.Contrasenia%TYPE,
    ID_Rol_I IN Estudiante.ID_Rol%TYPE,
    ID_Carrera_I IN Estudiante.ID_Carrera%TYPE,
    MENSAJE OUT varchar2
)
Is
    COMPROBAR_Estudiante number;
    Estudiante_No_Existente EXCEPTION;
BEGIN
 
    LOCK TABLE Estudiante IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Estudiante) INTO COMPROBAR_Estudiante FROM Estudiante WHERE ID_Estudiante_I = ID_Estudiante;
 
 
    IF COMPROBAR_Estudiante = 1 THEN
        UPDATE Estudiante
        SET Nombre_Estudiante = Nombre_Estudiante_I , Email = Email_I, Telefono = Telefono_I, Contrasenia = Contrasenia_I, ID_Rol = ID_Rol_I,  ID_Carrera = ID_Carrera
        WHERE ID_Estudiante = ID_Estudiante_I;
        MENSAJE := 'Estudiante Actualizado correctamente';
        COMMIT;
    ELSE
        RAISE Estudiante_No_Existente;
    END IF;
 
    EXCEPTION
        WHEN Estudiante_No_Existente THEN
            MENSAJE := 'El codigo del estudiante no encuentra en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ACTUALIZAR_Ramo(
    ID_Ramo_I IN Ramo.ID_Ramo%TYPE,
    Nombre_Ramo_I IN Ramo.Nombre_Ramo%TYPE,
    MENSAJE OUT varchar2
)
IS
    COMPROBAR_Ramo number;
    Ramo_No_Existente EXCEPTION;
BEGIN
 
    LOCK TABLE Ramo IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Ramo) INTO COMPROBAR_Ramo FROM Ramo WHERE ID_Ramo_I = ID_Ramo;
 
 
    IF COMPROBAR_Ramo = 1 THEN
        UPDATE Ramo
        SET  Nombre_Ramo = Nombre_Ramo_I
        WHERE ID_Ramo = ID_Ramo_I;
        MENSAJE := 'Ramo Actualizado correctamente';
        COMMIT;
    ELSE
        RAISE Ramo_No_Existente;
    END IF;
 
    EXCEPTION
        WHEN Ramo_No_Existente THEN
            MENSAJE := 'El codigo del Ramo no se encuentra en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ACTUALIZAR_Imparte_Ramo(
    ID_Profesor_I IN Imparte_Ramo.ID_Profesor%TYPE,
    ID_Ramo_I IN Imparte_Ramo.ID_Ramo %TYPE,
    MENSAJE OUT varchar2
)
   
IS
    COMPROBAR_Profesor number;
    COMPROBAR_Ramo number;
    ErrorActualizar EXCEPTION;
    
BEGIN
 
    LOCK TABLE Imparte_Ramo IN ROW EXCLUSIVE MODE;
    SELECT COUNT (ID_Profesor) INTO COMPROBAR_Profesor FROM Imparte_Ramo WHERE ID_Profesor_I = ID_Profesor;
    SELECT COUNT(ID_Ramo) INTO COMPROBAR_Ramo FROM Imparte_Ramo WHERE ID_Ramo_I = ID_Ramo;

    IF COMPROBAR_Ramo=1 and COMPROBAR_Profesor=1 THEN
        UPDATE Imparte_Ramo
        SET ID_Profesor = ID_Profesor_I
        WHERE  ID_Ramo = ID_Ramo_I;
        MENSAJE := 'Ramo Actualizada  correctamente';
        COMMIT;
    ELSE
        RAISE ErrorActualizar;
    END IF;
 
    EXCEPTION
        WHEN ErrorActualizar THEN
            MENSAJE := 'El codigo de la Pregunta Realizada no existe en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ACTUALIZAR_Cursa_Ramo(
    ID_Estudiante_I IN Cursa_Ramo.ID_Estudiante%TYPE,
    ID_Ramo_I IN Cursa_Ramo.ID_Ramo %TYPE,
    MENSAJE OUT varchar2
)
   
IS
    COMPROBAR_Ramo number;
    COMPROBAR_Estudiante number;
    ErrorActualizar EXCEPTION;
BEGIN
 
    LOCK TABLE Cursa_Ramo IN ROW EXCLUSIVE MODE;
    SELECT COUNT (ID_Estudiante) INTO COMPROBAR_Estudiante FROM Cursa_Ramo WHERE ID_Estudiante_I = ID_Estudiante;
    SELECT COUNT(ID_Ramo) INTO COMPROBAR_Ramo FROM Cursa_Ramo WHERE ID_Ramo_I = ID_Ramo;

    IF COMPROBAR_Ramo = 1 and COMPROBAR_Estudiante = 1 THEN
        UPDATE Cursa_Ramo
        SET ID_Ramo = ID_Ramo_I
        WHERE ID_Estudiante = ID_Estudiante_I;
        MENSAJE := 'Ramo Actualizada  correctamente';
        COMMIT;
    ELSE
        RAISE ErrorActualizar;
    END IF;
 
    EXCEPTION
        WHEN ErrorActualizar THEN
            MENSAJE := 'El codigo de la Pregunta Realizada no existe en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ACTUALIZAR_Solicitud(
    ID_Solicitud_I IN Solicitud.ID_Solicitud%TYPE,
    Prioridad_I IN Solicitud.Prioridad%TYPE,
    Contenido_I IN Solicitud.Contenido%TYPE,
    Categoria_I IN Solicitud.Categoria%TYPE,
    Fecha_solicitud_I IN Solicitud.Fecha_Solicitud%TYPE,
    MENSAJE OUT varchar2
)
Is
    COMPROBAR_Solicitud number;
    Solicitud_No_Existente EXCEPTION;
BEGIN
 
    LOCK TABLE Solicitud IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Solicitud) INTO COMPROBAR_Solicitud FROM Solicitud WHERE ID_Solicitud_I = ID_Solicitud;
 
 
    IF COMPROBAR_Solicitud = 1 THEN
        UPDATE Solicitud
        SET Prioridad = Prioridad_I, Contenido = Contenido_I, Categoria = Categoria_I, Fecha_Solicitud = Fecha_Solicitud_I
        WHERE ID_Solicitud = ID_Solicitud_I;
        MENSAJE := 'Solicitud Actualizada correctamente';
        COMMIT;
    ELSE
        RAISE Solicitud_No_Existente;
    END IF;
 
    EXCEPTION
        WHEN Solicitud_No_Existente THEN
            MENSAJE := 'El codigo de la Solicitud no existe en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM || ' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ACTUALIZAR_Pregunta(
    ID_Pregunta_I IN Pregunta.ID_Pregunta%TYPE,
    Prioridad_I IN Pregunta.Prioridad%TYPE,
    Contenido_I IN Pregunta.Contenido%TYPE,
    Categoria_I IN Pregunta.Categoria%TYPE,
    Destinatario_I IN Pregunta.Destinatario%TYPE,
    Fecha_Pregunta_I IN Pregunta.Fecha_Pregunta%TYPE,
    MENSAJE OUT varchar2
)
   
IS
    COMPROBAR_Pregunta number;
    Pregunta_No_Existente EXCEPTION;
BEGIN
 
    LOCK TABLE Pregunta IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Pregunta) INTO COMPROBAR_Pregunta FROM Pregunta WHERE ID_Pregunta_I = ID_Pregunta;
 
 
    IF COMPROBAR_Pregunta = 1 THEN
        UPDATE Pregunta
        SET Prioridad = Prioridad_I ,Contenido = Contenido_I, Categoria = Categoria_I, Destinatario = Destinatario_I, Fecha_Pregunta = Fecha_Pregunta_I
        WHERE ID_Pregunta = ID_Pregunta_I;
        MENSAJE := 'Pregunta Actualizada correctamente';
        COMMIT;
    ELSE
        RAISE Pregunta_No_Existente;
    END IF;
 
    EXCEPTION
        WHEN Pregunta_No_Existente THEN
            MENSAJE := 'El codigo de la Pregunta no existe en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ACTUALIZAR_Solicitud_Realizada(
    Estado_I IN Solicitud_Realizada.Estado%TYPE,
    Fecha_solicitud_I IN Solicitud_Realizada.Fecha_Solicitud%TYPE,
    ID_Solicitud_I IN Solicitud_Realizada.ID_Solicitud%TYPE,
    ID_Estudiante_I IN Solicitud_Realizada.ID_Estudiante%TYPe,
    MENSAJE OUT varchar2
)
Is
    COMPROBAR_Solicitud_Realizada number;
    COMPROBAR_ID_Estudiante NUMBER;
    ErrorActualizar EXCEPTION;
BEGIN
 
    LOCK TABLE Solicitud_Realizada IN ROW EXCLUSIVE MODE;
    SELECT COUNT (ID_Solicitud) INTO COMPROBAR_Solicitud_Realizada FROM Solicitud_Realizada WHERE ID_Solicitud_I = ID_Solicitud;
    SELECT COUNT(ID_Estudiante) INTO COMPROBAR_ID_Estudiante FROM Solicitud_Realizada WHERE ID_Estudiante_I = ID_Estudiante;
 
 
    IF COMPROBAR_Solicitud_Realizada = 1 and COMPROBAR_ID_Estudiante = 1 THEN
        UPDATE Solicitud_Realizada
        SET Estado = Estado_I , Fecha_Solicitud = Fecha_Solicitud_I , ID_Solicitud = ID_Solicitud_I, ID_Estudiante = ID_Estudiante_I
        WHERE ID_Estudiante = ID_Estudiante_I;
        MENSAJE := 'Solicitud Actualizada correctamente';
        COMMIT;
    ELSE
        RAISE ErrorActualizar;
    END IF;
 
    EXCEPTION
        WHEN ErrorActualizar THEN
            MENSAJE := 'El codigo de la Solicitud no existe en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM || ' - ' || SQLCODE;
            ROLLBACK;
END;    

CREATE OR REPLACE PROCEDURE ACTUALIZAR_Pregunta_Realizada(
    Estado_I IN Pregunta_Realizada.Estado%TYPE,
    Fecha_Pregunta_I IN Pregunta_Realizada.Fecha_Pregunta%TYPE,
    ID_Pregunta_I IN Pregunta_Realizada.ID_Pregunta%TYPE,
    ID_Estudiante_I IN Pregunta_Realizada.ID_Estudiante%TYPE,
    MENSAJE OUT varchar2
)
   
IS
    COMPROBAR_Pregunta_Realizada number;
    COMPROBAR_ID_Estudiante number;
    ErrorActualizar EXCEPTION;
BEGIN
 
    LOCK TABLE Pregunta_Realizada IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Pregunta) INTO COMPROBAR_Pregunta_Realizada FROM Pregunta_Realizada WHERE ID_Pregunta_I = ID_Pregunta;
    SELECT COUNT (ID_Estudiante) INTO COMPROBAR_ID_Estudiante FROM Pregunta_Realizada WHERE ID_Estudiante_I = ID_Estudiante;
 
    IF COMPROBAR_Pregunta_Realizada = 1 and COMPROBAR_ID_Estudiante = 1 THEN
        UPDATE Pregunta_Realizada
        SET Estado = Estado_I , Fecha_Pregunta = Fecha_Pregunta_
        WHERE ID_Pregunta = ID_Pregunta_I and ID_Estudiante = ID_Estudiante_I;
        MENSAJE := 'Pregunta Realizada Actualizada  correctamente';
        COMMIT;
    ELSE
        RAISE ErrorActualizar;
    END IF;
 
    EXCEPTION
        WHEN ErrorActualizar THEN
            MENSAJE := 'El codigo de la Pregunta Realizada no existe en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM  ||' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE ACTUALIZAR_Preguntas_Frecuentes(
    ID_Preguntas_Frecuentes_I IN Preguntas_Frecuentes.ID_Preguntas_Frecuentes%TYPE,
    Titulo_I IN Preguntas_Frecuentes.Titulo%TYPE,
    Categoria_I IN Preguntas_Frecuentes.Categoria%TYPE,
    Contenido_I IN Preguntas_Frecuentes.Contenido%TYPE,
    MENSAJE OUT varchar2
)
Is
    COMPROBAR_Preguntas_Frecuentes number;
    Pregunta_Frecuente_No_Existente EXCEPTION;
BEGIN
 
    LOCK TABLE Preguntas_Frecuentes IN ROW EXCLUSIVE MODE;
    SELECT COUNT(ID_Preguntas_Frecuentes) INTO COMPROBAR_Preguntas_Frecuentes FROM Preguntas_Frecuentes WHERE ID_Preguntas_Frecuentes_I = ID_Preguntas_Frecuentes;
 
 
    IF COMPROBAR_Preguntas_Frecuentes = 1 THEN
        UPDATE Preguntas_Frecuentes
        SET Titulo = Titulo_I, Categoria = Categoria_I, Contenido = Contenido_I
        WHERE ID_Preguntas_Frecuentes = ID_Preguntas_Frecuentes_I;
        MENSAJE := 'Solicitud Actualizada correctamente';
        COMMIT;
    ELSE
        RAISE Pregunta_Frecuente_No_Existente;
    END IF;
 
    EXCEPTION
        WHEN Pregunta_Frecuente_No_Existente THEN
            MENSAJE := 'El codigo de la pregunta frecuente no existe en la base de datos';
            ROLLBACK;
        WHEN OTHERS THEN
            MENSAJE:= 'Ha ocurrido un error en la base de datos-'|| SQLERRM || ' - ' || SQLCODE;
            ROLLBACK;
END;

CREATE SEQUENCE SECUENCIA_ID_Carrera
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999
    MINVALUE 1;
    
CREATE SEQUENCE SECUENCIA_ID_Ramo
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999
    MINVALUE 1;
    
CREATE SEQUENCE SECUENCIA_ID_Estudiante
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999
    MINVALUE 1;

CREATE SEQUENCE SECUENCIA_ID_Pregunta
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999
    MINVALUE 1;
    
CREATE SEQUENCE SECUENCIA_ID_Solicitud
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999
    MINVALUE 1;
    
CREATE SEQUENCE SECUENCIA_ID_Preguntas_Frecuentes
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999
    MINVALUE 1;
    
CREATE SEQUENCE SECUENCIA_ID_Director
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999
    MINVALUE 1;
    
CREATE SEQUENCE SECUENCIA_ID_Profesor
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999
    MINVALUE 1;
    
CREATE SEQUENCE SECUENCIA_ID_Secretaria
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999
    MINVALUE 1;

CREATE SEQUENCE SECUENCIA_ID_Rol
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999
    MINVALUE 1;
