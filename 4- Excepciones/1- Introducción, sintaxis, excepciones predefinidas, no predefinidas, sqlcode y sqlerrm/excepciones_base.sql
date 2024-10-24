/*
    INTRODUCCIÓN, SINTAXIS, EXCEPCIONES PREDEFINIDAS,EXCEPCIONES NO PREDEFINIDAS, SQLCODE Y SQLERRM
*/


/*
    Introducción
*/


/*
    Introducción a las excepciones: 
    son mecanismos que permiten manejar errores o situaciones 
    inesperadas durante la ejecución de un bloque de código. 
    Cuando ocurre un error, el control del programa pasa a la sección 
    de manejo de excepciones para tomar medidas.
    
    Hay 2 tipos:
        - Oracle (predefinidas): 
            NO_DATA_FOUND: No se encontró ningún dato.
            TOO_MANY_ROWS: La consulta devuelve más de una fila.
            ZERO_DIVIDE: Intento de dividir entre cero.
            
        - Usuario: Crea las propias excepciones
        
        BEGIN
           -- Acá va el área de excepciones, después del código
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Manejo del error
            WHEN OTHERS THEN
                -- Manejo de cualquier otro error
        END;
END;
*/


/*
    Sintaxis
*/


SET SERVEROUTPUT ON
DECLARE
    -- Declaración de variable
    empleado employees%ROWTYPE;
BEGIN
    
    -- Sentencia select
    SELECT * 
        INTO empleado
    FROM 
        EMPLOYEES
    WHERE 
        EMPLOYEE_ID = 1000;
    
    dbms_output.put_line(empleado.first_name);
    

--Siempre va despues del código principal en un bloque PL/SQL
EXCEPTION
    -- Manejo de una excepción especifica (excepcion1)
    WHEN excepcion1 THEN
        NULL;
    WHEN excepcion2 THEN
        NULL;
    -- Manejo de cualquier otra excepciónn no especificada antes
    WHEN OTHERS THEN
        NULL;
END;
/


/*
    Excepciones predefinidas
*/


SET SERVEROUTPUT ON
DECLARE
    -- Declaración de variable
    empleado employees%rowtype;
BEGIN
    -- Dará error, demasiado ejemplos
    SELECT
        *
    INTO empleado
    FROM
        employees
    WHERE
        employee_id > 1;

    dbms_output.put_line(empleado.first_name);
    

--Siempre va despues del código principal en un bloque PL/SQL
EXCEPTION
    -- Manejo de una excepciónn especifica (excepcion1)
    WHEN no_data_found THEN
        dbms_output.put_line('Error, empleado inexistente');
    WHEN too_many_rows THEN
        dbms_output.put_line('Error, demasiados empleados');
    WHEN OTHERS THEN
        dbms_output.put_line('Error no definido');
END;
/


/*
    PEQUEÑA PRACTICA MÍA
*/


/*
    Ejercicio 1: Excepción NO_DATA_FOUND
    Escribe un bloque PL/SQL que intente recuperar los datos de un empleado usando su employee_id. 
    Si el empleado no existe, captura la excepción NO_DATA_FOUND y muestra un mensaje adecuado.
*/


SET SERVEROUTPUT ON
DECLARE
    empleado EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * 
        INTO empleado
    FROM 
        employees
    WHERE 
        employees.employee_id = 1000;
    
    dbms_output.put_line('Empleado: ' || empleado.first_name || ' ' || empleado.last_name);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Empleado no encontrado');
    WHEN OTHERS THEN
        dbms_output.put_line('Error no definido');
END;
/


/*
    Ejercico 2: TOO_MANY_ROWS
    Escribe un bloque PL/SQL que recupere el salario de un empleado por su departamento. 
    Si hay más de un empleado en el departamento, captura la excepciónn 
    TOO_MANY_ROWS y muestra un mensaje de error.
*/


DECLARE
    salario employees.salary%TYPE;
BEGIN
    SELECT salary 
        INTO salario
    FROM 
        employees
    WHERE 
        department_id = 90;  -- Un departamento con varios empleados
    
    dbms_output.put_line('Salario del empleado: ' || salario);
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('No encontrado');
        WHEN TOO_MANY_ROWS THEN
            dbms_output.put_line('Demasiadas filas, error');
        WHEN OTHERS THEN
            dbms_output.put_line('Error no definido');
END;
/


/*
    Ejercicio 3: ZERO_DIVIDE
    Crea un bloque que intente dividir dos nÃºmeros. Si ocurre cualquier tipo de error, 
    captura la excepciÃ³n general OTHERS y muestra un mensaje.
*/


DECLARE
    numero1 NUMBER := 3;
    numero2 NUMBER := 0;
    resultado NUMBER;
BEGIN
    resultado := numero1 / numero2;
    
    dbms_output.put_line(resultado);
    
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            dbms_output.put_line('No se puede realizar la divisiónn');
END;
/


/*
    Excepciones no predefinidas (Son de oracle)
    https://docs.oracle.com/database/121/LNPLS/errors.htm#LNPLS99869
*/


DECLARE
    -- Declaración de una excepción personalizada
    miexcepcion EXCEPTION;

    -- Asignación de un código de error SQL específico a la excepción personalizada
    -- El código de error -937 está siendo asociado a la variable miexcepcion
    PRAGMA exception_init (miexcepcion, -937);

    -- Declaración de dos variables para almacenar resultados de la consulta
    v1 NUMBER;
    v2 NUMBER;
BEGIN
    -- Intento de ejecutar una consulta SQL que puede generar una excepción
    SELECT
        employee_id,  -- Se busca seleccionar un ID de empleado
        SUM(salary)   -- Se intenta calcular la suma de los salarios
    INTO
        v1,           -- Almacena el employee_id
        v2            -- Almacena la suma de salarios
    FROM
        employees; 

    -- Muestra el valor de v1 (employee_id) si la consulta fue exitosa
    dbms_output.put_line(v1);
    
EXCEPTION
    -- Manejo de la excepción personalizada si ocurre el error -937
    WHEN miexcepcion THEN
        dbms_output.put_line('Funcion de grupo incorrecta');

    -- Manejo de cualquier otra excepción no definida anteriormente
    WHEN OTHERS THEN
        dbms_output.put_line('Error indefinido');
END;
/


/*
    SQLCODE y SQLERRM
    Son funciones de PL/SQL que permiten obtener el código y descripción del problema respectivamente
*/


DECLARE
    empleado employees%ROWTYPE;
    
    --miExcepcion EXCEPTION;
    
    --PRAGMA exception_init(miExcepcion, -1422);
BEGIN
    SELECT * 
        INTO empleado
    FROM 
        employees;
    
    dbms_output.put_line(empleado.salary);
    
EXCEPTION
    WHEN too_many_rows THEN
        dbms_output.put_line('Más filas que las permitidas');
    WHEN OTHERS THEN
        dbms_output.put_line(SQLCODE); -- Proporciona el código del error
        dbms_output.put_line(SQLERRM); -- Proporciona la descripción del error
    
  --  WHEN miExcepcion THEN
  --      dbms_output.put_line('la recuperación devuelve un número mayor de filas que el permtido');
END;
/


/*
    PRACTICA
*/


/*
    Ejercicio 1:
    
    Crear una SELECT (no un cursor explícito) que devuelva el nombre de un
    empleado pasándole el EMPLOYEE_ID en el WHERE
    
    - Comprobar en primer lugar que funciona pasando un empleado existente
    - Pasar un empleado inexistente y comprobar que genera un error
    - Crear una zona de EXCEPTION controlando el NO_DATA_FOUND 

    Modificar la SELECT para que devuelva más de un empleado, por ejemplo
    poniendo EMPLOYEE_ID> 100. Debe generar un error. Controlar la
    excepción para que genere un mensaje como "Demasiados empleados
    en la consulta"

*/


SET SERVEROUTPUT ON
--Declaración de variables
DECLARE
    
    --Creaciónn de variable nombre con el tipo de dato de la columna nombre
    empleado_nombre employees.first_name%TYPE;
    
BEGIN
    SELECT
        employees.first_name
    INTO 
        empleado_nombre
    FROM
        employees
    WHERE
       -- employees.employee_id = 100;
        employees.employee_id > 100;
        
    dbms_output.put_line('Nombre: ' || empleado_nombre);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No existe');
    WHEN too_many_rows THEN
        dbms_output.put_line('No es posible traer más de una fila');
END;
/


/*
    Modificar la consulta para que devuelva un error de divisiónn por CERO,
    por ejemplo, vamos a devolver el salario en vez del nombre y lo dividimos
    por 0. En este caso, en vez de controlar la excepciónn directamente,
    creamos una secciónn WHEN OTHERS y pintamos el error con SQLCODE
    y SQLERRM
*/


SET SERVEROUTPUT ON
--Declaración de variables
DECLARE    
    --Creación de variable salario
    salario number;
BEGIN
    SELECT
        employees.salary
    INTO salario
    FROM
        employees
    WHERE
       employees.employee_id = 100;
       
       salario := salario / 0;
    dbms_output.put_line(salario);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No existe');
    WHEN too_many_rows THEN
        dbms_output.put_line('No es posible traer mÃ s de una fila');
    WHEN OTHERS THEN
        dbms_output.put_line(SQLCODE);
        dbms_output.put_line(SQLERRM);
END;
/


/*
    Ejercicio 3:
    El error -00001 es clave primaria duplicada
    
    Aunque ya existe una predefinida (DUP_VAL_ON_INDEX) vamos a
    crear una excepción no -predefinida que haga lo mismo.
    
    - Vamos a usar la tabla REGIONS para hacerlo más fácil
    - Usamos PRAGMA EXCEPTION_INIT y creamos una excepciónn
    denominada "duplicado".
    - Cuando se genere ese error debemos pintar "Clave duplicada, intente
    otra".   
*/


SET SERVEROUTPUT ON

DECLARE
    restricionclaveprimariaduplicada EXCEPTION;
    PRAGMA exception_init (restricionclaveprimariaduplicada, -00001);
BEGIN
    -- Insertamos el registro
    INSERT INTO regions 
    VALUES (1, 'nueva');

EXCEPTION
    WHEN restricionclaveprimariaduplicada THEN
        dbms_output.put_line('Clave duplicada, intente otra');
END;
/