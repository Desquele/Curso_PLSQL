

/*
    TRIGGERS
    INTRODUCCI�N, 
*/


/*
    INTRODUCCI�N
    Los triggers son bloques de c�digo que se ejecutan autom�ticamente
    en respuesta a eventos espec�ficos en una tabla o vista
  
    Ejemplos:
    
    DML -> INSERT, UPDATE, DELETE
    DDL -> Cambios en la estructura de la base de datos (create, drop)
    DATABASE -> Eventos del sistema (LOGON, SHUTDOWN)
*/


/*
    Tipos y eventos en los triggers
    
    TIPO:
        - DML TRIGGERS
            Eventos: INSERT, UPDATE DELETE
            Filas afectadas: 
                - Por fila(FOR EACH ROW)
                - Declaraci�n completa (BEFORE/AFTER)
            
        - DDL TRIGGERS
            Eventos: CREATE, ALTER y DROP
            Filas afectadas:
                - Unicamente afecta a nivel de declaraci�n
        
        - Database Triggers: 
            Eventos: LOGON, LOGOFF, SHUTDOWN, STARTUP
            Filas afectadas:
                - No afecta directamente filas, se ejecuta en
                eventos a nivel de la base de datos
            
*/


/*
    CREAR UN TRIGGER
*/


-- Creaci�n del trigger
CREATE OR REPLACE TRIGGER TRG_INS_EMPL 
-- Despu�s que se inserte un registro en la tabla regions se activara
AFTER INSERT ON regions
BEGIN
    -- Se guardar� la siguiente informaci�n
    INSERT INTO registro_regions
    VALUES('Regi�n incertada', USER, SYSDATE, 1);
    
END;
/


-- insertando un registro para comprobar que el trigger funcione correctamente
INSERT INTO REGIONS
VALUES(7, 'prueba');



/*
    Impedir operaciones con triggers
*/

-- Creaci�n del trigger
CREATE OR REPLACE TRIGGER tr1_region
-- Antes que se inserte un registro en la tabla regions se activara
BEFORE INSERT ON regions
BEGIN
    -- Si el usuario es distinto a HR
    IF USER <> 'HR' THEN
        RAISE_APPLICATION_ERROR(-20000, 'Solo HR puede insertar en regions');
    END IF;
END;
/



/*
    CREAR TRIGGERS CON EVENTOS M�LTIPLES
*/
CREATE OR REPLACE TRIGGER tr1_region
-- Antes que se inserte, actualize o elimine un registro en la tabla regions se activara
BEFORE INSERT OR UPDATE OR DELETE ON regions
BEGIN

     -- Si el usuario es distinto a HR
    IF USER <> 'HR' THEN
        RAISE_APPLICATION_ERROR(-20000, 'Solo HR puede insertar en regions');
    END IF;
END;
/


/*
    CONTROLAR EL TIPO DE EVENTO
*/

CREATE TABLE registro_areas
(
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,  
    REGISTRO_COLUMNA1 VARCHAR2(100 BYTE) NOT NULL,  
    NOMBRE_USUARIO VARCHAR2(40 BYTE),  
    FECHA DATE NOT NULL  
);

-- Se define el trigger
CREATE OR REPLACE TRIGGER tr1_areas_multiple
--  se activa antes de cualquier operaci�n de INSERT, UPDATE o DELETE en la tabla REGIONS
BEFORE INSERT OR UPDATE OR DELETE ON areas
BEGIN

    -- Si se est� realizando una inserci�n en la tabla REGIONS
    IF INSERTING THEN
        -- Se registra la operaci�n de inserci�n
        INSERT INTO registro_areas(registro_columna1, nombre_usuario, fecha)
        VALUES('Insercion', USER, SYSDATE);
    END IF;
    
    -- Si se est� actualizando el campo id
    IF UPDATING('id') THEN
        -- Se registra la actualizaci�n
        INSERT INTO registro_areas(registro_columna1, nombre_usuario, fecha)
        VALUES('Actualizaci�n id', USER, SYSDATE);
    END IF;
    
    -- Si se est� actualizando el campo nombre
    IF UPDATING('nombre') THEN
        -- Se registra la actualizaci�n 
        INSERT INTO registro_areas(registro_columna1, nombre_usuario, fecha)
        VALUES('Actualiacion nombre', USER, SYSDATE);
    END IF;
    
    -- Si se est� eliminando una area
    IF DELETING THEN
        -- Se registra la operaci�n de eliminaci�n 
        INSERT INTO registro_areas(registro_columna1, nombre_usuario, fecha)
        VALUES('Eliminacion', USER, SYSDATE);
    END IF;
END;
/

SELECT * FROM registro_areas;

INSERT INTO areas
VALUES(3, 'Gerencia');

UPDATE areas
SET nombre = 'Gerencia2'
WHERE id = 4;

DELETE FROM areas
WHERE id = 4;

INSERT INTO areas
VALUES(5, 'Recursos humanos');

/*
    TRIGGERS DE TIPO ROW
    
    se ejecutan una vez por cada fila afectada por una operaci�n DML 
    (INSERT, UPDATE, DELETE). Estos triggers permiten controlar y realizar acciones 
    sobre cada fila modificada, accediendo a los valores antiguos y nuevos de los campos 
    mediante las variables :OLD y :NEW.
*/

-- Se define el trigger
CREATE OR REPLACE TRIGGER tr1_areas_multiple_each_row
--  se activa antes de cualquier operaci�n de INSERT, UPDATE o DELETE en la tabla REGIONS
BEFORE INSERT OR UPDATE OR DELETE 
ON areas
FOR EACH ROW
WHEN (NEW.id >100) -- Solo se activa cuando el id sea mayor a 100
BEGIN

    -- Si se est� realizando una inserci�n en la tabla REGIONS
    IF INSERTING THEN
        -- Se registra la operaci�n de inserci�n
        INSERT INTO registro_areas(registro_columna1, nombre_usuario, fecha)
        VALUES('Nuevo valor: ' || :NEW.nombre, USER, SYSDATE);
    END IF;
    
    -- Si se est� actualizando el campo id
    IF UPDATING('id') THEN
        -- Se registra la actualizaci�n
        INSERT INTO registro_areas(registro_columna1, nombre_usuario, fecha)
        VALUES('Actualizaci�n id', USER, SYSDATE);
    END IF;
    
    -- Si se est� actualizando el campo nombre
    IF UPDATING('nombre') THEN
        -- Se registra la actualizaci�n 
        INSERT INTO registro_areas(registro_columna1, nombre_usuario, fecha)
        VALUES('Actualiacion nombre', USER, SYSDATE);
    END IF;
    
    -- Si se est� eliminando una area
    IF DELETING THEN
        -- Se registra la operaci�n de eliminaci�n 
        INSERT INTO registro_areas(registro_columna1, nombre_usuario, fecha)
        VALUES('Eliminacion', USER, SYSDATE);
    END IF;
END;
/


/*
    COMPROBAR EL ESTADO DE LOS TRIGGERS
    
*/
DESC USER_TRIGGERS;
SELECT 
    trigger_name, 
    trigger_type, 
    trigger_body
FROM
    USER_TRIGGERS;
    
    
/*
    DESACTIVAR TRIGGER
*/
ALTER TRIGGER tr1_areas_multiple_each_row DISABLE;

/*
    ACTIVAR TRIGGER
*/
ALTER TRIGGER tr1_areas_multiple_each_row ENABLE;



/*
    COMPILAR
*/

ALTER TRIGGER tr1_areas_multiple_each_row COMPILE;




/*
    TRIGGGER COMPOUND -> TRIGGERS COMPUESTOS
    Un Compound Trigger en PL/SQL es un tipo especial de trigger que combina 
    m�ltiples secciones para manejar eventos BEFORE y AFTER en un mismo bloque, 
    lo que permite reducir el uso de variables globales y optimizar el rendimiento.
    
    - Varios momentos en un solo trigger: Puedes manejar eventos como 
    BEFORE y AFTER para INSERT, UPDATE o DELETE en un solo trigger.
    
    - Optimizaci�n para filas: Es �til cuando se trabaja con filas m�ltiples (operaciones bulk), 
    ya que puede manejar eventos por bloque de filas, en lugar de activarse para cada fila individualmente.
    
    Secciones: Un compound trigger tiene hasta cuatro secciones opcionales:
    
        - BEFORE STATEMENT: Se ejecuta una vez antes de cualquier fila.
        
        - BEFORE EACH ROW: Se ejecuta antes de cada fila afectada.
        
        - AFTER EACH ROW: Se ejecuta despu�s de cada fila afectada.
        
        - AFTER STATEMENT: Se ejecuta una vez despu�s de que todas las filas hayan sido procesadas
*/



CREATE OR REPLACE TRIGGER TRG_COMPOUND
FOR INSERT OR UPDATE ON areas
COMPOUND TRIGGER

  -- Secci�n BEFORE STATEMENT para inicializar variables,validaciones
  -- BEFORE STATEMENT: Se ejecuta una vez antes de cualquier fila.
  BEFORE STATEMENT IS
  BEGIN
    dbms_output.put_line('BEFORE STATEMENT');
  END BEFORE STATEMENT;

  -- Secci�n BEFORE EACH ROW
  -- BEFORE EACH ROW: Se ejecuta antes de cada fila afectada.
  BEFORE EACH ROW IS
  BEGIN
    dbms_output.put_line('BEFORE EACH ROW');
  END BEFORE EACH ROW;

  -- Secci�n AFTER EACH ROW
  -- AFTER EACH ROW: Se ejecuta despu�s de cada fila afectada.
  AFTER EACH ROW IS
  BEGIN
    dbms_output.put_line('AFTER EACH ROW');
  END AFTER EACH ROW;

  -- Secci�n AFTER STATEMENT
  -- AFTER STATEMENT: Se ejecuta una vez despu�s de que todas las filas hayan sido procesadas.
  AFTER STATEMENT IS
  BEGIN
    dbms_output.put_line('AFTER STATEMENT');
  END AFTER STATEMENT;

END trg_compound;
/


/*
    Ejemplo adaptado
*/

CREATE OR REPLACE TRIGGER tr1_areas_compound
FOR INSERT OR UPDATE OR DELETE ON areas
COMPOUND TRIGGER

  -- Variables globales
  usuario VARCHAR2(50);
  fecha DATE;

  -- Secci�n BEFORE STATEMENT
  BEFORE STATEMENT IS
  BEGIN
    -- Inicializaci�n
    usuario := USER;
    fecha := SYSDATE;
  END BEFORE STATEMENT;

  -- Secci�n BEFORE EACH ROW
  BEFORE EACH ROW IS
  BEGIN
    -- Verificar si el id es mayor a 100
    IF :NEW.id > 100 THEN
      -- Si se est� realizando una inserci�n
      IF INSERTING THEN
        INSERT INTO registro_areas(registro_columna1, nombre_usuario, fecha)
        VALUES('Nuevo valor: ' || :NEW.nombre, usuario, fecha);
      END IF;

      -- Si se est� actualizando el campo id
      IF UPDATING('id') THEN
        INSERT INTO registro_areas(registro_columna1, nombre_usuario, fecha)
        VALUES('Actualizaci�n id', usuario, fecha);
      END IF;

      -- Si se est� actualizando el campo nombre
      IF UPDATING('nombre') THEN
        INSERT INTO registro_areas(registro_columna1, nombre_usuario, fecha)
        VALUES('Actualizaci�n nombre', usuario, fecha);
      END IF;

      -- Si se est� eliminando una �rea
      IF DELETING THEN
        INSERT INTO registro_areas(registro_columna1, nombre_usuario, fecha)
        VALUES('Eliminaci�n', usuario, fecha);
      END IF;
      
    END IF;
  END BEFORE EACH ROW;

END tr1_areas_compound;
/




/*
    PRACTICAS PRIMERA PARTE, INSERT, DELEET Y UPDATE
*/

/*
     EJERCICIO 1:
     CREAR TRIGGER DE AUDITOR�A AL INSERTAR EN LA TABLA areas
     Crea un trigger que se active despu�s de una inserci�n en la tabla 
     employees. Al activarse, debe insertar un registro en una tabla de auditor�a 
     llamada auditoria_area, almacenando el nombre de la area insertado, el usuario que realiz� la acci�n, y la fecha de la operaci�n.
*/

-- Creaci�n del trigger
CREATE OR REPLACE TRIGGER TR_auditoria_area
AFTER INSERT ON areas
FOR EACH ROW
BEGIN
    -- Insertar registro despues de cada inserci�n en la tabla
    INSERT INTO auditoria_area(area_incertada, usuario, fecha_operacion)
    VALUES(:NEW.nombre, USER, SYSDATE);
END;
/

-- Insertando registro
INSERT INTO areas
VALUES(6, 'Gerencia');


/*
    EJERCICIO 2:
    Trigger al borrar registros en departments: 
    Crea un trigger que se active antes de eliminar un registro 
    en la tabla departments. El trigger debe insertar un registro en una tabla 
    llamada registro_departments_eliminados, indicando el nombre del departamento eliminado y
    la fecha.
*/

-- Creaci�n de tabla
CREATE TABLE registro_departments_eliminados (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    departamento VARCHAR2(100) NOT NULL,
    fecha_operacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creaci�n del trigger
CREATE OR REPLACE TRIGGER TR_ELIMINAR_DEPARTAMENTOS
AFTER INSERT ON departments
FOR EACH ROW
BEGIN
    -- Insertar despu�s de que se elimina un registro en lla tabla departments
    INSERT INTO registro_departments_eliminados(departamento, fecha_operacion)
    VALUES(:NEW.department_name, SYSDATE);
END;
/


/*
    EJERCICIO 3:
    rigger al actualizar el salario en employees: Crea un trigger que se ejecute 
    despu�s de una actualizaci�n del salario en la tabla employees. El trigger debe 
    guardar en una tabla log_cambios_salario el employee_id, el salario antes del cambio, 
    el salario despu�s del cambio, y la fecha del cambio.
*/

-- Creaci�n de la tabla
CREATE TABLE log_cambios_salario (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_empleado NUMBER NOT NULL,
    salario_antes NUMBER,
    salario_despues NUMBER NOT NULL
);

-- Creaci�n del trigger
CREATE OR REPLACE TRIGGER tr_salarios_empleados
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    -- Insertar
    INSERT INTO log_cambios_salario (id_empleado, salario_antes, salario_despues)
    VALUES(:NEW.employee_id, :OLD.salary, :NEW.salary);
END;
/
UPDATE EMPLOYEES
SET
    salary = 5000
WHERE employee_id = 100;    


/*
    PRACTICA SEGUNDA PARTE, IMPEDIR OPERACIONES CON TRIGGERS
*/

/*
    EJERCICIO 1:
    Evitar inserciones en employees fuera del horario laboral: 
    Crea un trigger que impida realizar inserciones en la tabla 
    employees fuera del horario laboral (por ejemplo, de 8:00 AM a 6:00 PM), 
    usando la funci�n SYSDATE para obtener la hora actual.
*/

CREATE OR REPLACE TRIGGER TR_EVITAR_INSERCIONES_EMPLOYEES
BEFORE INSERT ON employees
BEGIN
    IF TO_CHAR(SYSDATE, 'HH24:MI') < '08:00' AND TO_CHAR(SYSDATE, 'HH24:MM') > '18:00' THEN
        RAISE_ERROR_APPLICATION('-20001', 'No se puede insertar fuera del horario laboral');
    END IF;
END;
/


/*
    EJERCICIO 2:
    Evitar actualizaciones de salario por parte de usuarios 
    no autorizados: Crea un trigger que impida actualizar el 
    salario de los empleados en la tabla employees si el 
    usuario que intenta hacer la operaci�n no pertenece al 
    departamento de Recursos Humanos (HR).
*/
CREATE OR REPLACE TRIGGER TR_REGULAR_USUARIO_NO_ACTUALIZADO
BEFORE UPDATE ON employees
BEGIN
    
    IF USER <> 'HR' THEN
        IF UPDATING('salary') THEN
                RAISE_APPLICATION_ERROR('-20002', 'No se puede actualizar el salario');
        END IF;    
    END IF;
   
END;