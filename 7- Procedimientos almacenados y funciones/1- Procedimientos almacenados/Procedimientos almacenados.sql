/*
        INTRODUCCI�N A PROCEDIMIENTOS Y FUNCIONES
  
        PROCEDIMIENTOS
        Un procedimiento es un bloque PL/SQL que realiza
        una acci�n espec�fica, como actualizar registros o procesar c�lculos.
        No necesariamente devuelve un valor
        

        FUNCIONES
        Similar a un procedimiento, pero siempre devuelve un valor.
        Es �til para c�lculos que se integran en SQL Y PL/SQL

        PASOS DE CREACI�N
    
        1- CREAR EL OBJETO  
            Oracle guarda:
            - CODIGO FUENTE utilizado en la creaci�n
            - CODIGO PSEUDO-COMPILADO
            
        2- INVOCAR EN CUALQUIER MOMENTO, PL/SQL y SQL

*/


/*
    CREAR UN PROCEDIMIENTO
*/

-- Creaci�n

/*
-- Creamos el procedimiento
CREATE OR REPLACE PROCEDURE p_mostrar_numero 
-- Ac� va la zona de declaraci�n
IS
    numero NUMBER := 4;
BEGIN
    -- Imprimimos el resultado
    dbms_output.put_line(numero);
END p_mostrar_numero;
/
*/


/*
   UTILIZACI�N
    
-- Utilizaci�n forma 1 dentro de un bloque
SET SERVEROUTPUT ON
BEGIN
    -- Se manda a llamar el procedimiento
    p_mostrar_numero;
END;
/

-- Utilizaci�n 2 se utiliza EXECUTE
EXECUTE p_mostrar_numero;
*/




/*
    Ver el c�digo fuente de un procedimiento o funci�n
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

-- Ver el c�digo fuente
/*
SELECT
    *
FROM 
    USER_SOURCE
WHERE 
    NAME = 'P_MOSTRAR_NUMERO';
*/


-- Ver el c�digo en formato texto
/*
SELECT
    TEXT
FROM 
    USER_SOURCE
WHERE 
    NAME = 'P_MOSTRAR_NUMERO';
*/



/*
    PAR�METROS EN FUNCIONES Y PROCEDIMIENTOS
*/
    


/*
    PAR�METRO TIPO IN
    Es el parametro por defecto.
    Las variables entran solo de lectura por ende no se puede modificar
*/

/*
-- Creamos el procedimiento almacenado
CREATE OR REPLACE PROCEDURE p_calcular_descuento
(
    -- par�metros de entrada
    empleado_obtenido IN employees.employee_id%TYPE,
    impuesto_obtenido IN NUMBER
)
IS
    -- Declaraci�n de variables
    descuento_salario NUMBER := 0;
    salario NUMBER := 0;
BEGIN
    -- Si el impuesto es menos a 0 o mayor a 60 no se aplicar� el salario y se mandar� un mensaje
    IF impuesto_obtenido < 0 OR impuesto_obtenido > 60 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El porcentaje debe de estar entre 0 y 60');
    END IF;
    
    -- Obteniendo el salario del empleado que se pas� su id
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
    -- En caso se propocione un id que no pertenezca a ning�n empleado
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
    PAR�METROS OUT
    Permite que devuelva un valor dentro de un procedimiento
*/

/*
-- Creamos el procedimiento almacenado
CREATE OR REPLACE PROCEDURE P_CALCULAR_DESCUENTO_OUT
(
    -- par�metros de entrada
    empleado_obtenido IN employees.employee_id%TYPE,
    impuesto_obtenido IN NUMBER,
    resultado OUT NUMBER
)
IS
    -- Declaraci�n de variables
    salario NUMBER := 0;
BEGIN
    -- Si el impuesto es menos a 0 o mayor a 60 no se aplicar� el salario y se mandar� un mensaje
    IF impuesto_obtenido < 0 OR impuesto_obtenido > 60 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El porcentaje debe de estar entre 0 y 60');
    END IF;
    
    -- Obteniendo el salario del empleado que se pas� su id
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
    -- En caso se propocione un id que no pertenezca a ning�n empleado
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
    Par�metros de tipo IN - OUT
*/
/*
CREATE OR REPLACE PROCEDURE P_CALCULAR_DESCUENTO_IN_OUT
(
    -- par�metros de entrada
    empleado_obtenido IN employees.employee_id%TYPE,
    impuesto_obtenido IN OUT NUMBER
)
IS
    -- Declaraci�n de variables
    salario NUMBER := 0;
BEGIN
    -- Si el impuesto es menos a 0 o mayor a 60 no se aplicar� el salario y se mandar� un mensaje
    IF impuesto_obtenido < 0 OR impuesto_obtenido > 60 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El porcentaje debe de estar entre 0 y 60');
    END IF;
    
    -- Obteniendo el salario del empleado que se pas� su id
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
    -- En caso se propocione un id que no pertenezca a ning�n empleado
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
    PR�CTICA DE PROCEDIMIENTOS ALMACENADOS
*/

/*
    Ejercicio 1:
    Crear un procedimiento llamado �visualizar� que visualice el nombre y
    salario de todos los empleados 
*/

/*
CREATE OR REPLACE PROCEDURE P_MOSTRAR_NOMBRE_SALARIO_EMPLEADO
IS
    -- Declaraci�n de cursor
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
    UTILIZACI�N DE PROCEDIMIENTO
*/

--EXECUTE P_MOSTRAR_NOMBRE_SALARIO_EMPLEADO;





/*
    Ejercicio 2:
    Modificar el programa anterior para incluir un par�metro que pase el
    n�mero de departamento para que visualice solo los empleados de ese
    departamento
    � Debe devolver el n�mero de empleados en una variable de tipo OUT
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
    UTILIZACI�N DE PROCEDIMIENTO
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
    Crear un bloque por el cual se de formato a un n�mero de cuenta
    suministrado por completo, por ejmplo: 11111111111111111111
    � Formateado a: 1111-1111-11-1111111111
    � Debemos usar un par�metro de tipo IN-OUT
*/

-- Creaci�n del procedimiento
/*
CREATE OR REPLACE PROCEDURE formateo_cuenta 
(
    -- Declaraci�n de par�metros de entrada
    numero IN OUT VARCHAR2
) IS
    -- Declaraci�n de variables
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