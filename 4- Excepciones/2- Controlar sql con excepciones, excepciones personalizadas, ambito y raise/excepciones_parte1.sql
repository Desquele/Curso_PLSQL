/*
    CONTROLAR SQL CON EXCEPCIONES, EXCEPCIONES PERSONALIZADAS, �MBITO DE LAS EXCEPCIONES 
    Y RAISE_APPLICATION_ERROR
*/

/*
    Controla SQL con excepciones
*/
/*
SET SERVEROUTPUT ON
DECLARE
    --Declaraci�n de variables
    reg regions%rowtype;
    reg_control regions.region_id%TYPE;
BEGIN
    --Asignaci�nn de valores
    reg.region_id := 100;
    reg.region_name := 'AFRICA';
    
    --Consulta SQL
    SELECT
        region_id
    INTO reg_control
    FROM
        regions
    WHERE
        region_id = reg.region_id;
    
    --Mostrar el resultado
    dbms_output.put_line('La regi�n ya existe');
EXCEPTION
    WHEN no_data_found THEN
        INSERT INTO regions 
        VALUES (reg.region_id,reg.region_name);
        COMMIT;
END;
*/



/*
    Excepciones de usuario
    SOn las excepciones creadas por los usuarios 
*/
/*
DECLARE
    -- 1. Definir una excepci�n personalizada
    excepcion_region_maxima EXCEPTION;
    
    -- Declarar variables para almacenar los valores de la regi�n
    id_region NUMBER;          -- Almacena el ID de la regi�n
    nombre_region VARCHAR2(200);  -- Almacena el nombre de la regi�n

BEGIN
    -- Asignar valores a las variables
    id_region := 101;          
    nombre_region := 'ASIA';   

    -- Condici�n para verificar si el ID de la regi�n es mayor a 100
    IF id_region > 100 THEN
        -- 2. Lanzar la excepci�n personalizada si el ID es mayor que 100
        RAISE excepcion_region_maxima;
    ELSE
        -- Si el ID es menor o igual a 100, insertar la regi�n en la tabla 'regions'
        INSERT INTO regions
        VALUES (id_region, nombre_region);
    END IF;

EXCEPTION
    -- 3. Manejo de la excepci�n 'excepcion_region_maxima'
    WHEN excepcion_region_maxima THEN
        -- Mostrar un mensaje cuando el ID de la regi�n es mayor que 100
        dbms_output.put_line('El ID de la regi�n no puede ser mayor que 100');

    -- Manejo de cualquier otra excepci�n no especificada
    WHEN OTHERS THEN
        -- Mostrar un mensaje con el c�digo de error y su descripci�n
        dbms_output.put_line('Código de error: ' || SQLCODE || ', Descripción: ' || SQLERRM);
END;
*/


/*
    Crear una Excepci�n personalizada denominada
    CONTROL_REGIONES.

*/

/*
SET SERVEROUTPUT ON
DECLARE
    -- 1. Definir la variable
    control_regiones EXCEPTION;
    id_region regions.region_id%TYPE;
    nombre_region regions.region_name%TYPE;
BEGIN
    id_region := 201;
    nombre_region := 'ejemplo';
    
    if id_region > 200 THEN
        -- 2. Lanzar la excepci�n personalizada
        RAISE control_regiones;
    ELSE
        INSERT INTO regions
        VALUES(id_region, nombre_region);
    END IF;
    
EXCEPTION
    -- 3. Manejo de la excepci�n
    WHEN control_regiones THEN
        dbms_output.put_line('Debe ser inferior a 200');
END;
/
*/


/*
    Ambitos de las excepciones "Similar a las variables de los bloques"
    0 sea, el bloque hijo puede acceder a los atributos del bloque padre pero no al revez
*/
/*
DECLARE
    -- Declaraci�n de variables principales
    region_id NUMBER;               
    region_name VARCHAR2(200);   
BEGIN
    -- Asignaci�n de valores a las variables
    region_id := 101;              
    region_name := 'ASIA';
    
    -- Bloque anidado
    DECLARE
        -- Declaraci�nn de excepci�n personalizada
        region_id_exceed EXCEPTION; 
    BEGIN
        -- Verifica si el ID de la regi�n es mayor que 100
        IF region_id > 100 THEN
            -- Si el ID es mayor que 100, lanza la excepci�n region_id_exceed
            RAISE region_id_exceed;
        ELSE
            -- Si el ID es menor o igual a 100, inserta la regi�n en la tabla 'regions'
            INSERT INTO regions
            VALUES (region_id, region_name);
            COMMIT;  -- Realiza un commit para guardar los cambios en la base de datos
        END IF;
    EXCEPTION
        -- Captura la excepci�n region_id_exceed lanzada en el bloque anidado
        WHEN region_id_exceed THEN
            -- Muestra un mensaje si el ID es mayor a 100
            DBMS_OUTPUT.PUT_LINE('El ID de la regi�n no puede ser mayor de 100. BLOQUE HIJO');
    END;
END;
*/



/*
    RAISE_APPLICATION_ERROR
    C�digo que puedo utilizar en rango de -20000 Y -20999
*/
/*
DECLARE
    -- Declarar variables para almacenar los valores de la regi�n
    id_region NUMBER;          -- Almacena el ID de la regi�n
    nombre_region VARCHAR2(200);  -- Almacena el nombre de la regi�n

BEGIN
    -- Asignar valores a las variables
    id_region := 101;          
    nombre_region := 'ASIA';   

    -- Condici�n para verificar si el ID de la regi�n es mayor a 100
    IF id_region > 100 THEN
        -- Lanzar la excepci�n  si el ID es mayor que 100
        RAISE_APPLICATION_ERROR(-20001, 'LA ID NO PUEDE SER MAYOR DE 100'); (-20000 Y -20999)
    ELSE
        -- Si el ID es menor o igual a 100, insertar la regi�n en la tabla 'regions'
        INSERT INTO regions
        VALUES (id_region, nombre_region);
    END IF;
END;
*/


/*
    PRACTICA
*/


/*
    EJERCICIO:
    
    Crear una Excepci�n personalizada denominada CONTROL_REGIONES.
    
    - Debe dispararse cuando al insertar o modificar una regi�n 
    queramos poner una clave superior a 200. Por ejemplo usando una 
    variable con ese valor.
    - En ese caso debe generar un texto indicando algo as� como 
    �Codigo no permitido. Debe ser inferior a 200�
    - Recordemos que las excepciones personalizadas deben 
    dispararse de forma manual con el RAISE
*/

/*
SET SERVEROUTPUT ON

DECLARE
    control_regiones EXCEPTION;
    codigo NUMBER := 201;
BEGIN
    IF codigo > 200 THEN
        RAISE control_regiones;
    ELSE
        INSERT INTO regions 
        VALUES (codigo,'PRUEBA');

    END IF;
EXCEPTION
    WHEN control_regiones THEN
        dbms_output.put_line('El codigo debe ser inferior a 200');
    WHEN OTHERS THEN
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
END;

*/



/*
    Modificar la practica anterior para disparar un error con RAISE_APPLICATION 
    en vez de con PUT_LINE.
        a. Esto permite que la aplicaci�n pueda capturar y gestionar el error que 
        devuelve el PL/SQL
*/

SET SERVEROUTPUT ON

DECLARE
    control_regiones EXCEPTION;
    codigo NUMBER := 201;
BEGIN
    IF codigo > 200 THEN
        RAISE control_regiones;
    ELSE
        INSERT INTO regions 
        VALUES (codigo,'PRUEBA');

    END IF;
EXCEPTION
    WHEN control_regiones THEN
        raise_application_error(-20001, 'El codigo debe ser inferior a 200');
    WHEN OTHERS THEN
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
END;
