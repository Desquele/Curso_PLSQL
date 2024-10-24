/*
    INSERTS, UPDATES Y DELETES EN PL/SQL
*/


/*
    INSERTS
*/


SET SERVEROUTPUT ON
DECLARE
    -- Variable con el mismo tipo de la columna c1
    columna_c1 test.C1%TYPE;
BEGIN
    -- Inicialización de variable
    columna_c1:=20;
    
    -- Insertando registro en la tabla Test
    INSERT INTO TEST (c1, c2)
    VALUES (columna_c1, 'Enrique');
    
    COMMIT; -- Deberia de llevarlo en insert, update, delete
END;
/


/*
    UPDATES
*/


DECLARE
    -- Variable con el mismo tipo de la columna c1
    columna_c1 test.C1%TYPE;
BEGIN
    -- Inicialización de variable
    t:=10;
    
    -- Haciendo un update
    UPDATE TEST
        SET c2= 'Des'
    WHERE c1 = columna_c1;
    
    commit;
END;
/


/*
    DELETE
*/


DECLARE
    -- Variable con el mismo tipo de la columna c1
    columna_c1 test.C1%TYPE;
BEGIN
    columna_c1 := 10;
    
    DELETE FROM TEST 
    WHERE c1 = columna_c1;
    
    COMMIT;
END;
/ 


/*
    PRACTICAS
*/


/*
    Practica 1:
    
    Crear un bloque que inserte un nuevo departamento en la tabla
    DEPARTMENTS. Para saber el DEPARTMENT_ID que debemos asignar al
    nuevo departamento primero debemos averiguar el valor mayor que hay en la
    tabla DEPARTMENTS y sumarle uno para la nueva clave
    
    - Location_id debe ser 1000
    - Manager_id debe ser 100
    - Department_name debe ser â€œINFORMATICAâ€?
    
    NOTA: en PL/SQL debemos usar COMMIT y ROLLBACK de la misma
    forma que lo hacemos en SQL. Por tanto, para validar definitivamente un
    cambio debemos usar COMMIT.
    
    
*/


SET SERVEROUTPUT ON
DECLARE
    -- Declaracion de variables 
    departamento_idMayor departments.department_id%TYPE;
    departamento_location_id departments.location_id%TYPE;
    departmento_manager_id departments.manager_id%TYPE;
    departamento_departamento_nombre departments.department_name%TYPE;
BEGIN
    
    -- Inicialización de variables
    departamento_location_id := 1000;
    departamento_departamento_nombre := 'INFORMATICA';
    departmento_manager_id := 100;
    
    -- Obtener el id mayor del departamento
    SELECT 
        MAX(department_id) 
    INTO departamento_idMayor
    FROM DEPARTMENTS;
    
    -- Le sumamos uno para que no haya problemas de restricción unique
    departamento_idMayor := departamento_idMayor + 1;
    
    -- Insertamos el nuevo departamento
    INSERT INTO DEPARTMENTS(department_id,department_name,manager_id,location_id)
    VALUES(departamento_idMayor, departamento_departamento_nombre, 
    departmento_manager_id, departamento_location_id);
    
    COMMIT;
END;
/


/*
        Ejercicio 2:
        Crear un bloque PL/SQL que modifique la LOCATION_ID del nuevo
        departamento a 1700. En este caso usemos el COMMIT dentro del bloque
        PL/SQL.
*/


SET SERVEROUTPUT ON
DECLARE
    -- Declaración de variables
    id_location departments.location_id%TYPE;  
BEGIN
    -- Inicialización de variable
    id_location := 1700;
    
    UPDATE DEPARTMENTS
    SET departments.location_id = id_location
    WHERE department_id = 271;
END;
/


/*
    Ejercicio 3:
    Por último, hacer otro bloque PL/SQL que elimine ese departamento nuevo.
*/

DECLARE
    id_departamento DEPARTMENTS.department_id%TYPE;
BEGIN
    -- Inicialización de variable
    id_departamento := 271;
   
    DELETE FROM DEPARTMENTS
    WHERE departments.department_id = id_departamento;
END;
/
