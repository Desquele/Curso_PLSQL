/*
    SELECTS DENTRO DE PL/SQL y %ROWTYPE
*/


/*
    SELECTES DENTRO DE PL/SQL
    El resultado del select se deben de guardar en variable, para ello,
    se utiliza la clausula INTO.   
    
    Solo puede devolver una sola fila, no 0 no más de una (se soluciona con cursores)
*/


-- Cuando se ocupa solo un resultado
/*
SET SERVEROUTPUT ON
DECLARE
    -- Declaracion de variable donde se guardará  el resultado
    salario NUMBER; 
BEGIN
    --Obtener el salario del empleado id 100
    SELECT 
        salary INTO salario --Into indica donde se guardara el resultado (en este caso en salario)
    FROM 
        EMPLOYEES
    WHERE
        employee_id = 100;
        
    --Mostrando el resultado
    dbms_output.put_line(salario);
END;
*/


--Cuando se trae más de un resultado
/*
SET SERVEROUTPUT ON

DECLARE
    -- Declaración de variable para almacenar el salario
    salario NUMBER; 
    -- Variable con tipo de dato de la columna FIRST_NAME
    nombre  employees.first_name%TYPE; 
BEGIN
    -- Obtener el salario y nombre del empleado con ID 100
    SELECT salary, first_name
        INTO salario, nombre
    FROM
        employees
    WHERE
        employee_id = 100;
    
    -- Mostrar el resultado
    dbms_output.put_line(nombre || ' tiene un salario de: ' || salario);
END;
*/





/*
    %ROWTYPE
    Se usa para declarar una variable que puede almacenar una fila completa de una tabla o 
    el resultado de una consulta con una estructura similar a la de una tabla o vista. 
    
    Esta hereda la estructura y tipos de datos de todas las columnas de la tabla o consulta
*/

/*
SET SERVEROUTPUT ON

DECLARE
     --Variable que almacena toda una fila de empleados
    empleado employees%ROWTYPE;
BEGIN
    -- Obtener el salario y nombre del empleado con ID 100
    SELECT *
        INTO empleado -- Se guarda toda la columna dentro de la variable empleado
    FROM
        employees
    WHERE
        employee_id = 100;
    
    -- Mostrar el resultado
    dbms_output.put_line(empleado.first_name || ' tiene un salario de: ' || empleado.salary);
END;
*/




/*
    PRÁCTICAS
*/



/*
    Practica 1:
    Crear un bloque PL/SQL que devuelva al salario máximo del
    departamento 100 y lo deje en una variable denominada salario_maximo
    y la visualice
*/  

/*
SET SERVEROUTPUT ON
DECLARE
    --Variable que contendrá  el salario, con el tipo de dato de la columna 'salary'
    salario_maximo employees.salary%TYPE; 
BEGIN
    SELECT MAX(salary) 
        INTO salario_Maximo
    FROM 
        EMPLOYEES
    WHERE 
        department_id = 100;
    
    --Mostrar resultado
    dbms_output.put_line('El salario maximo del departamento 100 es:' || salario_Maximo);
END;
*/




/*
    Practica 2:
    Visualizar el tipo de trabajo del empleado número 100
*/

/*
SET SERVEROUTPUT ON
DECLARE
    --Variable que contendrá  el tipo de trabajo, con el tipo de dato de la columna 'job_id'
    tipoTrabajo employees.job_id%TYPE;
BEGIN
    SELECT job_id 
        INTO tipoTrabajo
    FROM 
        EMPLOYEES
    WHERE 
        employee_id = 100;
    
    --Mostrar resultado
    dbms_output.put_line('EL tipo de trabajo es: ' || tipoTrabajo);
END;
*/


/*
    Practica 3
    
    - Crear una variable de tipo DEPARTMENT_ID y ponerla algún valor, por ejemplo 10.
      
    - Visualizar el nombre de ese departamento y el número de empleados que tiene
      Crear dos variables para albergar los valores.
*/

/*
SET SERVEROUTPUT ON
DECLARE
    -- Declaracion de variable, con el mismo tipo de dato de department_id
    departamento_id DEPARTMENTS.department_id%TYPE;
    
    -- Declaracion de variable, con el mismo tipo de dato de department_name
    departamento_nombre DEPARTMENTS.department_name%type;
    
    -- Declaración de variable se guardará el numero de empleados
    numero_empleados number;
    
BEGIN

    -- Inicialización de variables
    departamento_id := 10;
    
    --Traer el nombre del departmento
    SELECT department_name
        INTO departamento_nombre
    FROM 
        DEPARTMENTS
    WHERE 
        department_id = departamento_id;
    
    --Traer el número de empleados
    SELECT COUNT(*)
        INTO numero_empleados
    FROM EMPLOYEES
    WHERE department_id = departamento_id;
    
    -- Mostrando el resultado
    dbms_output.put_line(departamento_nombre);
    dbms_output.put_line(numero_empleados);
END;
*/



/*
    Practica 4:
    Mediante dos consultas recuperar el salario máximo y el salario mínimo
    de la empresa e indicar su diferencia
*/

/*
SET SERVEROUTPUT ON
DECLARE
    --Declaracion de variables
    salario_mayor number;
    salario_menor number;
    salario_diferencia number;
BEGIN
    
    SELECT 
        MAX(salary), MIN(salary)  
    INTO 
        salario_mayor, salario_menor
    FROM 
        EMPLOYEES;
    
    -- Variable donde se guarda la diferencia de salario
    salario_diferencia := salario_mayor - salario_menor;
    
    dbms_output.put_line('Salario mayor: ' || salario_mayor || ' ' || 'Salario menor: ' || salario_menor  ||  ' ' 
    || 'diferencia'  || ' ' || salario_diferencia);
END;

*/


