/*
    EJERCICIOS PROCEDIMIENTOS ALMACENADOS SIN PAR�METROS
*/


/*
    EJERCICIO 1:
    Crear un procedimiento para mostrar la fecha actual:
    Crea un procedimiento llamado mostrar_fecha que muestre 
    la fecha actual en formato DD-MON-YYYY.
*/

/*
CREATE OR REPLACE PROCEDURE p_mostrar_fecha_actual
-- Declaraci�n de variables
AS
BEGIN 
    dbms_output.put_line(to_char(sysdate, 'DD/MM/YYYY'));
END p_mostrar_fecha_actual;
/


-- Ejecutar el procedimiento
EXECUTE p_mostrar_fecha_actual;

*/



/*
    EJERCICIO 2:  
    Crear un procedimiento para listar todos los empleados:
    Crea un procedimiento llamado listar_empleados que liste todos los nombres 
    de los empleados de la tabla EMPLOYEES.
*/

/*
CREATE OR REPLACE PROCEDURE P_LISTAR_EMPLEADOS
-- Declaraci�n de variables
AS
    CURSOR c_mostrar_nombres_empleados IS SELECT first_name FROM employees;
BEGIN
    -- Mostrar
    FOR i IN c_mostrar_nombres_empleados LOOP
        dbms_output.put_line(i.first_name);
    END LOOP;
END P_LISTAR_EMPLEADOS;
/

-- Ejecutar el procedimiento
EXECUTE P_LISTAR_EMPLEADOS;
*/



/*
    EJERCICIO 3:
    Crear un procedimiento para contar el n�mero de departamentos:
    Crea un procedimiento llamado contar_departamentos que cuente y 
    muestre el n�mero total de departamentos en la tabla DEPARTMENTS.
*/
/*
CREATE OR REPLACE PROCEDURE P_CONTAR_DEPARTAMENTOS
AS
    numero_departamentos NUMBER;
BEGIN
    -- Consulta que devuelva el n�mero total de departamentos
    SELECT 
        COUNT(department_id)
    INTO
        numero_departamentos
    FROM 
        departments;
        
    -- Mostrar el n�mero de departamentos
    dbms_output.put_line('El n�mero de departamentos es: ' || numero_departamentos);
END P_CONTAR_DEPARTAMENTOS;
/

-- Ejecutar el procedimiento
EXECUTE P_CONTAR_DEPARTAMENTOS;
*/



/*
    EJERCICIO 4:
    Crear un procedimiento para mostrar un mensaje personalizado:
    Crea un procedimiento llamado mostrar_mensaje que muestre un mensaje 
    que diga "�Hola, este es un procedimiento sin par�metros!".
*/
/*
CREATE OR REPLACE PROCEDURE P_MOSTRAR_MENSAJE
AS
BEGIN
    dbms_output.put_line('Hola, este es un procedimiento sin par�metros');
END P_MOSTRAR_MENSAJE;
/

EXECUTE P_MOSTRAR_MENSAJE;
*/



/*
    EJERCICIO 5:
Crear un procedimiento para calcular el total de salarios:
Crea un procedimiento llamado calcular_total_salarios que calcule 
y muestre el total de los salarios de todos los empleados.
*/
/*
CREATE OR REPLACE PROCEDURE P_CALCULAR_TOTAL_SALARIOS
-- Declaraci�n de variables
AS
    suma_salarios NUMBER;
BEGIN
    -- Sentencia que obtiene la sumatoria de los salarios y lo guarda en la variable
    SELECT
        SUM(salary)
    INTO
        suma_salarios
    FROM
        employees;
    
    -- Mostrar la suma de los salarios
    dbms_output.put_line('La suma de los salarios es: ' || suma_salarios);
        
END P_CALCULAR_TOTAL_SALARIOS;
/

-- Eejecutar procedimiento almacenado
EXECUTE P_CALCULAR_TOTAL_SALARIOS;

*/





/*
    EJERCICIOS PROCEDIMIENTOS ALMACENADOS CON PAR�METRO IN
*/


/*
    EJERCICIO 1
    Crear un procedimiento que muestre la informaci�n de un empleado espec�fico:
    Crea un procedimiento llamado mostrar_informacion_empleado que tome como par�metro 
    el employee_id y muestre la informaci�n completa del empleado.
   
*/
/*
CREATE OR REPLACE PROCEDURE P_MOSTRAR_INFORMACION_EMPLEADO
(   -- Ac� va los par�metros de entrada
    employee_id_obtenido employees.employee_id%TYPE
)
AS
    -- Declaraci�n de variables
    empleado employees%ROWTYPE;
    nombre_departamento departments.department_name%TYPE;
BEGIN
    
    -- Seleccionar la informaci�n del empleado
    SELECT 
        *
    INTO 
        empleado
    FROM 
        employees
    WHERE 
        employee_id = employee_id_obtenido;
    
    -- Seleccionar el nombre del departamento
    SELECT 
        department_name
    INTO 
        nombre_departamento
    FROM 
        departments
    WHERE 
        department_id = empleado.department_id;
        
    dbms_output.put_line('Nombre: ' || empleado.first_name || ' ' || empleado. last_name || ' ' ||
                        'Fecha de contrataci�n: ' || empleado.hire_date || ' ' ||
                        'Salario: ' || empleado.salary  || ' ' ||
                        'Id departamento: ' || NVL(TO_CHAR(empleado.department_id), 'N/A') || ' ' ||
                        'Nombre del departamento: ' || nombre_departamento);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('El id no corresponde a ning�n empleado');
    WHEN OTHERS THEN
        dbms_output.put_line('C�digo del error: ' || SQLCODE);
        dbms_output.put_line('Mensaje del error: ' || SQLERRM);
        
END MOSTRAR_INFORMACION_EMPLEADO;
/
-- Ejecutar procedimiento
EXECUTE P_MOSTRAR_INFORMACION_EMPLEADO(100);
*/



/*
    Ejercicio 2
    Crear un procedimiento que calcule el aumento de salario:
    Crea un procedimiento llamado calcular_aumento que tome 
    como par�metro un porcentaje de aumento y lo aplique a un salario 
    espec�fico pasado como par�metro.

*/
/*
CREATE OR REPLACE PROCEDURE P_CALCULAR_AUMENTO
(   -- Par�metros
    aumento_salario_obtenido number,
    employee_id_obtenido employees.employee_id%TYPE
)
AS
    -- Declaraci�n de variables
    salario_antes NUMBER;
    salario_despues NUMBER;
BEGIN
    -- Obtener el salario actual
    SELECT 
        salary
    INTO
        salario_antes
    FROM 
        employees
    WHERE
        employee_id = employee_id_obtenido;
        
        
    -- Calcular el nuevo salario
    salario_despues := salario_antes + (salario_antes * aumento_salario_obtenido / 100);
        
    UPDATE employees
    SET 
        salary = salario_despues
    WHERE 
        employee_id = employee_id_obtenido;
    
    dbms_output.put_line('El aumento fue de: ' || aumento_salario_obtenido || '%' || ' ' ||
                        'al empleado con id: ' || employee_id_obtenido);
                        
    dbms_output.put_line('Salario anterior: ' || ' ' || salario_antes || ' ' ||
                        'salario despu�s del aumento: ' || salario_despues);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No hay informaci�n');
    WHEN OTHERS THEN
        dbms_output.put_line('C�digo del error: ' || SQLCODE);
        dbms_output.put_line('Mensaje del error: ' || SQLERRM);
END P_CALCULAR_AUMENTO;
/

EXECUTE P_CALCULAR_AUMENTO(20,103);
*/



/*
    EJERCICIO 3:
    Crear un procedimiento que liste los empleados de un departamento espec�fico:
    Crea un procedimiento llamado listar_empleados_departamento que tome como
    par�metro el department_id y liste todos los empleados que pertenecen a ese departamento.
*/
/*
CREATE OR REPLACE PROCEDURE P_LISTAR_EMPLEADOS_DEPARTAMENTO
(
    department_id_obtenido NUMBER
)
AS
    -- Declaraci�n de cursor
    CURSOR c_empleados IS SELECT * FROM employees WHERE department_id = department_id_obtenido;
BEGIN
     FOR i IN c_empleados LOOP
        dbms_output.put_line('Nombre: ' || i.first_name || ' ' || i.last_name || ' ' ||
                            ', Numero de celular: ' || i.phone_number);
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('C�digo del error: ' || SQLCODE);
        dbms_output.put_line('Mensaje del error: ' || SQLERRM);
END P_LISTAR_EMPLEADOS_DEPARTAMENTO;
/

-- Ejecutar el procedimiento
EXECUTE P_LISTAR_EMPLEADOS_DEPARTAMENTO(00);
*/




/*
    EJERCICIO 4:
    Crear un procedimiento que muestre el nombre de un departamento:
    Crea un procedimiento llamado mostrar_nombre_departamento que tome como 
    par�metro el department_id y muestre el nombre del departamento correspondiente.

*/
/*
CREATE OR REPLACE PROCEDURE P_MOSTRAR_NOMBRE_DEPARTAMENTO
(
    department_id_obtenido NUMBER
)
AS  
    departamento_nombre departments.department_name%TYPE;
BEGIN

     -- Comprobar si el department_id es v�lido
    IF department_id_obtenido IS NULL THEN
        dbms_output.put_line('El ID de departamento no puede ser nulo.');
        RETURN;
    END IF;
    
    -- Sentencia para obtener el nombre
    SELECT 
        department_name
    INTO 
        departamento_nombre
    FROM
        departments
    WHERE
        department_id = department_id_obtenido;
        
    -- Mostrar el nombre
    dbms_output.put_line('El nombre del departamento es: ' || departamento_nombre);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No existe ning�n departamento con ese id');
END P_MOSTRAR_NOMBRE_DEPARTAMENTO;
/

-- Ejecutar el procedimiento almacenado
EXECUTE P_MOSTRAR_NOMBRE_DEPARTAMENTO(200);
*/


/*
    EJERCICIO 5:
    Crear un procedimiento que calcule el salario anual de un empleado:
    Crea un procedimiento llamado calcular_salario_anual que tome como 
    par�metro el employee_id y calcule y muestre el salario anual de ese empleado.
*/
CREATE OR REPLACE PROCEDURE P_CALCULAR_SALARIO_ANUAL
(
    -- Declaraci�n de par�metros
    employee_id_obtenido employees.employee_id%TYPE
)
AS
    -- Declaraci�n de variables
    salario employees.salary%TYPE;
BEGIN
    
    -- Consulta para obtener el salario
    SELECT 
        salary
    INTO 
        salario
    FROM
        employees
    WHERE 
        employee_id = employee_id_obtenido;
    
   
    -- Imprimir el resultado 
    dbms_output.put_line('El salario anual ser�: ' || (salario * 12));
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No existe ning�n empleado con ese id');
END P_CALCULAR_SALARIO_ANUAL;
/

-- Ejecutar el procedimiento almacenado
EXECUTE P_CALCULAR_SALARIO_ANUAL(100);