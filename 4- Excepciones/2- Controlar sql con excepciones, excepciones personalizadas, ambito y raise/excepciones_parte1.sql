/*
    CONTROLAR SQL CON EXCEPCIONES, EXCEPCIONES PERSONALIZADAS, ÁMBITO DE LAS EXCEPCIONES 
    Y RAISE_APPLICATION_ERROR
*/

/*
    Controla SQL con excepciones
*/
/*
SET SERVEROUTPUT ON
DECLARE
    --Declaración de variables
    reg regions%rowtype;
    reg_control regions.region_id%TYPE;
BEGIN
    --Asignaciónn de valores
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
    dbms_output.put_line('La región ya existe');
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
    -- 1. Definir una excepción personalizada
    excepcion_region_maxima EXCEPTION;
    
    -- Declarar variables para almacenar los valores de la región
    id_region NUMBER;          -- Almacena el ID de la región
    nombre_region VARCHAR2(200);  -- Almacena el nombre de la región

BEGIN
    -- Asignar valores a las variables
    id_region := 101;          
    nombre_region := 'ASIA';   

    -- Condición para verificar si el ID de la región es mayor a 100
    IF id_region > 100 THEN
        -- 2. Lanzar la excepción personalizada si el ID es mayor que 100
        RAISE excepcion_region_maxima;
    ELSE
        -- Si el ID es menor o igual a 100, insertar la región en la tabla 'regions'
        INSERT INTO regions
        VALUES (id_region, nombre_region);
    END IF;

EXCEPTION
    -- 3. Manejo de la excepción 'excepcion_region_maxima'
    WHEN excepcion_region_maxima THEN
        -- Mostrar un mensaje cuando el ID de la región es mayor que 100
        dbms_output.put_line('El ID de la región no puede ser mayor que 100');

    -- Manejo de cualquier otra excepción no especificada
    WHEN OTHERS THEN
        -- Mostrar un mensaje con el código de error y su descripción
        dbms_output.put_line('CÃ³digo de error: ' || SQLCODE || ', DescripciÃ³n: ' || SQLERRM);
END;
*/


/*
    Crear una Excepción personalizada denominada
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
        -- 2. Lanzar la excepción personalizada
        RAISE control_regiones;
    ELSE
        INSERT INTO regions
        VALUES(id_region, nombre_region);
    END IF;
    
EXCEPTION
    -- 3. Manejo de la excepción
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
    -- Declaración de variables principales
    region_id NUMBER;               
    region_name VARCHAR2(200);   
BEGIN
    -- Asignación de valores a las variables
    region_id := 101;              
    region_name := 'ASIA';
    
    -- Bloque anidado
    DECLARE
        -- Declaraciónn de excepción personalizada
        region_id_exceed EXCEPTION; 
    BEGIN
        -- Verifica si el ID de la región es mayor que 100
        IF region_id > 100 THEN
            -- Si el ID es mayor que 100, lanza la excepción region_id_exceed
            RAISE region_id_exceed;
        ELSE
            -- Si el ID es menor o igual a 100, inserta la región en la tabla 'regions'
            INSERT INTO regions
            VALUES (region_id, region_name);
            COMMIT;  -- Realiza un commit para guardar los cambios en la base de datos
        END IF;
    EXCEPTION
        -- Captura la excepción region_id_exceed lanzada en el bloque anidado
        WHEN region_id_exceed THEN
            -- Muestra un mensaje si el ID es mayor a 100
            DBMS_OUTPUT.PUT_LINE('El ID de la región no puede ser mayor de 100. BLOQUE HIJO');
    END;
END;
*/



/*
    RAISE_APPLICATION_ERROR
    Código que puedo utilizar en rango de -20000 Y -20999
*/
/*
DECLARE
    -- Declarar variables para almacenar los valores de la región
    id_region NUMBER;          -- Almacena el ID de la región
    nombre_region VARCHAR2(200);  -- Almacena el nombre de la región

BEGIN
    -- Asignar valores a las variables
    id_region := 101;          
    nombre_region := 'ASIA';   

    -- Condición para verificar si el ID de la región es mayor a 100
    IF id_region > 100 THEN
        -- Lanzar la excepción  si el ID es mayor que 100
        RAISE_APPLICATION_ERROR(-20001, 'LA ID NO PUEDE SER MAYOR DE 100'); (-20000 Y -20999)
    ELSE
        -- Si el ID es menor o igual a 100, insertar la región en la tabla 'regions'
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
    
    Crear una Excepción personalizada denominada CONTROL_REGIONES.
    
    - Debe dispararse cuando al insertar o modificar una región 
    queramos poner una clave superior a 200. Por ejemplo usando una 
    variable con ese valor.
    - En ese caso debe generar un texto indicando algo así como 
    “Codigo no permitido. Debe ser inferior a 200”
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
        a. Esto permite que la aplicación pueda capturar y gestionar el error que 
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
