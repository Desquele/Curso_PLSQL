/*
        INTRODUCCIÓN A PROCEDIMIENTOS Y FUNCIONES
  
        PROCEDIMIENTOS
        Un procedimiento es un bloque PL/SQL que realiza
        una acción específica, como actualizar registros o procesar cálculos.
        No necesariamente devuelve un valor
        

        FUNCIONES
        Similar a un procedimiento, pero siempre devuelve un valor.
        Es útil para cálculos que se integran en SQL Y PL/SQL

        PASOS DE CREACIÓN
    
        1- CREAR EL OBJETO  
            Oracle guarda:
            - CODIGO FUENTE utilizado en la creación
            - CODIGO PSEUDO-COMPILADO
            
        2- INVOCAR EN CUALQUIER MOMENTO, PL/SQL y SQL

*/


/*
    CREAR UN PROCEDIMIENTO
*/

-- Creación

/*
-- Creamos el procedimiento
CREATE OR REPLACE PROCEDURE p_mostrar_numero 
-- Acá va la zona de declaración
IS
    numero NUMBER := 4;
BEGIN
    -- Imprimimos el resultado
    dbms_output.put_line(numero);
END p_mostrar_numero;
/
*/


/*
   UTILIZACIÓN
    
-- Utilización forma 1 dentro de un bloque
SET SERVEROUTPUT ON
BEGIN
    -- Se manda a llamar el procedimiento
    p_mostrar_numero;
END;
/

-- Utilización 2 se utiliza EXECUTE
EXECUTE p_mostrar_numero;
*/




/*
    Ver el código fuente de un procedimiento o función
*/

-- USER_OBJECTS -> Permite ver todos los objectos

-- Ver todos los objetos que hay
/*
SELECT 
* 
FROM 
    USER_OBJECTS
WHERE
    OBJECT_TYPE = 'PROCEDURE';

*/


-- Ver cantidad de objetos
/*
SELECT 
    OBJECT_TYPE, 
    COUNT(*)
FROM 
    USER_OBJECTS
GROUP BY
    OBJECT_TYPE;
*/

-- Ver el código fuente
/*
SELECT
    *
FROM 
    USER_SOURCE
WHERE 
    NAME = 'P_MOSTRAR_NUMERO';
*/


-- Ver el código en formato texto
/*
SELECT
    TEXT
FROM 
    USER_SOURCE
WHERE 
    NAME = 'P_MOSTRAR_NUMERO';
*/



/*
    PARÁMETROS EN FUNCIONES Y PROCEDIMIENTOS
*/
    


/*
    PARÁMETRO TIPO IN
    Es el parametro por defecto.
    Las variables entran solo de lectura por ende no se puede modificar
*/

/*
-- Creamos el procedimiento almacenado
CREATE OR REPLACE PROCEDURE p_calcular_descuento
(
    -- parámetros de entrada
    empleado_obtenido IN employees.employee_id%TYPE,
    impuesto_obtenido IN NUMBER
)
IS
    -- Declaración de variables
    descuento_salario NUMBER := 0;
    salario NUMBER := 0;
BEGIN
    -- Si el impuesto es menos a 0 o mayor a 60 no se aplicará el salario y se mandará un mensaje
    IF impuesto_obtenido < 0 OR impuesto_obtenido > 60 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El porcentaje debe de estar entre 0 y 60');
    END IF;
    
    -- Obteniendo el salario del empleado que se pasó su id
    SELECT
        salary
    INTO
        salario
    FROM 
        employees
    WHERE
        employee_id = empleado_obtenido;
        
    -- Realizando los calculos
    descuento_salario := salario * impuesto_obtenido / 100;
    
    -- Imprimiendo
    dbms_output.put_line('Salary: ' || salario);
    dbms_output.put_line('Descuento obtenido: ' || descuento_salario);
    

EXCEPTION
    -- En caso se propocione un id que no pertenezca a ningún empleado
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No existe el empleado');
END;
/
*/


/*
    UTILIZANDO EL PROCEDIMIENTO ALMACENADO
*/

/*
SET SERVEROUTPUT ON
DECLARE
    -- Declaramos las variables
    id_empleado NUMBER;
    descuento NUMBER;
BEGIN
    
    -- Inicializamos las variables
    id_empleado := 120;
    descuento := 5;
    
    -- Mandamos a llamar el procedimiento almacenado y le pasamos los argumentos
    p_calcular_descuento(id_empleado, descuento);

END;
*/



/*
    PARÁMETROS OUT
    Permite que devuelva un valor dentro de un procedimiento
*/

/*
-- Creamos el procedimiento almacenado
CREATE OR REPLACE PROCEDURE P_CALCULAR_DESCUENTO_OUT
(
    -- parámetros de entrada
    empleado_obtenido IN employees.employee_id%TYPE,
    impuesto_obtenido IN NUMBER,
    resultado OUT NUMBER
)
IS
    -- Declaración de variables
    salario NUMBER := 0;
BEGIN
    -- Si el impuesto es menos a 0 o mayor a 60 no se aplicará el salario y se mandará un mensaje
    IF impuesto_obtenido < 0 OR impuesto_obtenido > 60 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El porcentaje debe de estar entre 0 y 60');
    END IF;
    
    -- Obteniendo el salario del empleado que se pasó su id
    SELECT
        salary
    INTO
        salario
    FROM 
        employees
    WHERE
        employee_id = empleado_obtenido;
        
    -- Realizando los calculos
    resultado := salario * impuesto_obtenido / 100;
    
    -- Imprimiendo
    dbms_output.put_line('Salary: ' || salario);    

EXCEPTION
    -- En caso se propocione un id que no pertenezca a ningún empleado
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No existe el empleado');
END;
/
*/



/*
    UTILIZANDO EL PROCEDIMIENTO ALMACENADO
*/


/*
SET SERVEROUTPUT ON
DECLARE
    id_empleado NUMBER;
    descuento NUMBER;
    r NUMBER;
BEGIN

    id_empleado := 120;
    descuento := 5;
    r := 0;
    
    P_CALCULAR_DESCUENTO_OUT(id_empleado, descuento, r);
    
    dbms_output.put_line('r: ' || r);

END;

*/




/*
    Parámetros de tipo IN - OUT
*/
/*
CREATE OR REPLACE PROCEDURE P_CALCULAR_DESCUENTO_IN_OUT
(
    -- parámetros de entrada
    empleado_obtenido IN employees.employee_id%TYPE,
    impuesto_obtenido IN OUT NUMBER
)
IS
    -- Declaración de variables
    salario NUMBER := 0;
BEGIN
    -- Si el impuesto es menos a 0 o mayor a 60 no se aplicará el salario y se mandará un mensaje
    IF impuesto_obtenido < 0 OR impuesto_obtenido > 60 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El porcentaje debe de estar entre 0 y 60');
    END IF;
    
    -- Obteniendo el salario del empleado que se pasó su id
    SELECT
        salary
    INTO
        salario
    FROM 
        employees
    WHERE
        employee_id = empleado_obtenido;
        
    dbms_output.put_line(impuesto_obtenido);
    -- Realizando los calculos
    impuesto_obtenido := salario * impuesto_obtenido / 100;
    
    -- Imprimiendo
    dbms_output.put_line('Salary: ' || salario);    

EXCEPTION
    -- En caso se propocione un id que no pertenezca a ningún empleado
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No existe el empleado');
END;
/
*/




/*
    UTILIZANDO EL PROCEDIMIENTO ALMACENADO
*/

/*
SET SERVEROUTPUT ON
DECLARE
    id_empleado NUMBER;
    descuento NUMBER;
BEGIN

    id_empleado := 120;
    descuento := 5;
    
    P_CALCULAR_DESCUENTO_IN_OUT(id_empleado, descuento);
    
    dbms_output.put_line('Descuento: ' || descuento);

END;
*/




/*
    PRÁCTICA DE PROCEDIMIENTOS ALMACENADOS
*/

/*
    Ejercicio 1:
    Crear un procedimiento llamado “visualizar” que visualice el nombre y
    salario de todos los empleados 
*/

/*
CREATE OR REPLACE PROCEDURE P_MOSTRAR_NOMBRE_SALARIO_EMPLEADO
IS
    -- Declaración de cursor
    CURSOR c_nombres_salarios_empleados IS SELECT first_name, salary FROM employees;
   
BEGIN   
    -- Mostrar los empleados
    FOR i IN c_nombres_salarios_empleados LOOP
        dbms_output.put_line('Nombre: ' || i.first_name || ', salario: ' || i.salary);
    END LOOP;
    

END P_MOSTRAR_NOMBRE_SALARIO_EMPLEADO;
/
*/
/*
    UTILIZACIÓN DE PROCEDIMIENTO
*/

--EXECUTE P_MOSTRAR_NOMBRE_SALARIO_EMPLEADO;





/*
    Ejercicio 2:
    Modificar el programa anterior para incluir un parámetro que pase el
    número de departamento para que visualice solo los empleados de ese
    departamento
    • Debe devolver el número de empleados en una variable de tipo OUT
*/

/*
CREATE OR REPLACE PROCEDURE P_MOSTRAR_NUMERO_EMPLEADOS_DEPARTAMENTO
(
    numero_departamento_obtenido IN NUMBER,
    numero_empleados OUT NUMBER
)
IS  
BEGIN   
    SELECT
        COUNT(*)
    INTO 
        numero_empleados
    FROM
        employees
    WHERE 
        department_id = numero_departamento_obtenido;
        
END P_MOSTRAR_NUMERO_EMPLEADOS_DEPARTAMENTO;
/


/*
    UTILIZACIÓN DE PROCEDIMIENTO
*/

/*
SET SERVEROUTPUT ON
DECLARE
 resultado NUMBER := 0;
BEGIN
    P_MOSTRAR_NUMERO_EMPLEADOS_DEPARTAMENTO(90, resultado);
    
    dbms_output.put_line('El resultado es: ' || resultado);
END;
*/



/*
    Crear un bloque por el cual se de formato a un número de cuenta
    suministrado por completo, por ejmplo: 11111111111111111111
    • Formateado a: 1111-1111-11-1111111111
    • Debemos usar un parámetro de tipo IN-OUT
*/

-- Creación del procedimiento
/*
CREATE OR REPLACE PROCEDURE formateo_cuenta 
(
    -- Declaración de parámetros de entrada
    numero IN OUT VARCHAR2
) IS
    -- Declaración de variables
    guardar1 VARCHAR2(20);
    guardar2 VARCHAR2(20);
    guardar3 VARCHAR2(20);
    guardar4 VARCHAR2(20);
BEGIN
    guardar1 := substr(numero, 1, 4);
    guardar2 := substr(numero, 5, 4);
    guardar3 := substr(numero, 9, 2);
    guardar4 := substr(numero, 10);
    
    
    numero := guardar1 || '-' || guardar2 || '-' || guardar3|| '-' || guardar4;
END;
/
*/