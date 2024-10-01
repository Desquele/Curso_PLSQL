/*
    FUNCIONES Y FUNCIONES EN COMANDOS SQL
*/

/*
    FUNCIONES
    Devuelven un valor
*/

CREATE OR REPLACE FUNCTION F_CALCULAR_DESCUENTO
(
    -- parámetros de entrada
    empleado_obtenido IN employees.employee_id%TYPE,
    impuesto_obtenido IN NUMBER
)
RETURN NUMBER -- Devuelve un valor de tipo númerico
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
    
    -- Retorna la variable
    RETURN descuento_salario;

EXCEPTION
    -- En caso se propocione un id que no pertenezca a ningún empleado
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No existe el empleado');
END;
/



/*
    UTILIZANDO LA FUNCIÓN
*/


SET SERVEROUTPUT ON
DECLARE
    -- Declaramos las variables
    id_empleado NUMBER;
    descuento NUMBER;
    resultado NUMBER;
BEGIN
    
    -- Inicializamos las variables
    id_empleado := 120;
    descuento := 5;
    
    -- Mandamo
    resultado := F_CALCULAR_DESCUENTO(id_empleado, descuento);
    
    dbms_output.put_line('El descuento es: ' || resultado);

END;
/

/*
    FUNCIONES EN COMANDOS SQL
*/
SELECT
    FIRST_NAME,
    SALARY,
    ROUND(F_CALCULAR_DESCUENTO(employee_id, 29), 2) AS "Descuento"
FROM
    employees;
    
    
