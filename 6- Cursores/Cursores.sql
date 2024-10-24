/*
    Cursores:
        Estructuras que permiten a los programas trabajar
        con conjuntos de resultados obtenidos de una consulta SQL
        
        1- Implicitos: 
        Se crean automáticamente cada vez que se ejecuta 
        una instrucción CRUD. Son utiizados cuando solo hay un único registro afectado
        
        2- Explicitos: 
        Deben ser declarados y gestionados manualmente. 
        Son útiles cuando la consulta devuelve varios registros o se necesita 
        mayor control sobre el procesamiento de filas. Se utiliza en consultas complejas que 
        devuelven más de una fila.
            
        Pasos: 
                Declarar el cursor.
                Abrir el cursor.
                Recuperar las filas con FETCH.
                Cerrar el cursor

*/


/*
    Atributos implicitos
*/


/*
SQL%ISOPEN -> Aplica solo a cursores explícitos porque verifica si un cursor está abierto.
SQL%FOUND --> Indica si se devolvió al menos una fila.
SQL%NOTFOUND -->  Indica si no se devolvieron filas.
SQL%ROWCOUNT --> Devuelve el número de filas afectadas por una operación SQL.
*/
DECLARE BEGIN
    
/*
    SQL%FOUND:
     Indica si la última operación DML (como INSERT, UPDATE, DELETE) o 
     una consulta SQL devolvió alguna fila.
     
     Valor:
        TRUE: Si la operación afectó alguna fila o devolvió un registro.
        FALSE: Si no devolvió filas.
*/

    UPDATE employees
    SET
        salary = salary * 1.1
    WHERE
        employee_id = 100;

    IF SQL%found THEN
        dbms_output.put_line('Se actualizó al menos un registro.');
    ELSE
        dbms_output.put_line('No se actualizaron registros.');
    END IF;
    
    
    
    
    /*
    SQL%NOTFOUND:
     Es el opuesto de %FOUND. 
     Indica si la operación no devolvió filas.
     
     Valor:
        TRUE:  Si no se afectó ninguna fila.
        FALSE:  Si se afectó alguna fila.
    */

    DELETE FROM employees
    WHERE
        employee_id = 999;

    IF SQL%notfound THEN
        dbms_output.put_line('No se encontró ningún empleado con ese ID.');
    END IF;
    
    
    /*
    SQL%ROWCOUNT:
     Devuelve el número de filas afectadas por la 
     última operación INSERT, UPDATE, DELETE o 
     la consulta SELECT INTO.
    */
    UPDATE employees
    SET
        salary = salary * 1.1
    WHERE
        employee_id = 100;

    dbms_output.put_line('Se actualizaron ' || SQL%rowcount || ' registros.');
END;
/



/*
    Crear cursor
*/


DECLARE
    -- Declarar el cursor
    CURSOR regions_cursor IS SELECT * FROM regions;

    -- Creación de la variable
    regions_fila regions%rowtype;
BEGIN
    -- Abrir el cursor
    OPEN regions_cursor;
    
    -- Leer el cursor y guardar el primer valor en la variable regions_fila
    FETCH regions_cursor INTO regions_fila;
    
    -- Imprimir
    dbms_output.put_line(regions_fila.region_name);
    
    
    -- Cerrar el cursor
    CLOSE regions_cursor;
END;
/


/*
    Atributos cursores explicitos
    
    nombreCursor%atributo
    
    nombreCursor%ISOPEN    
    nombreCursor%FOUND
    nombreCursor%NOTFOUND
    nombreCursor%ROWCOUNT
*/


/*
    Recorrer cursor
*/


-- LOOP
DECLARE
    -- Declaramos el cursor
    CURSOR cursor_regions IS SELECT * FROM regions;
    
    -- Declaramos variable
    fila_regions regions%rowtype;
BEGIN

    -- Abrimos cursor
    OPEN cursor_regions;
    
    -- Bucle
    LOOP
        FETCH cursor_regions INTO fila_regions;
        EXIT WHEN cursor_regions%NOTFOUND; -- Salir del bucle cuando ya no haya filas
        dbms_output.put_line(fila_regions.region_name);  
    END LOOP;
    
    -- Cerramos el cursor
    CLOSE cursor_regions;
END;
/


-- BUCLE FOR
DECLARE
    CURSOR cursor_regions IS SELECT * FROM regions;
BEGIN
    -- No se ocupa el open, close, fetch, into
    FOR i IN cursor_regions LOOP
        dbms_output.put_line(i.region_name);  
    END LOOP;
END;
/


-- BUCLE FOR CON SUBQUERIES
SET SERVEROUTPUT ON
BEGIN
    FOR i IN (SELECT * FROM REGIONS) LOOP
        dbms_output.put_line(i.region_name);
    END LOOP;
END;
/


/*
    Cursores con parametros
*/


DECLARE
    CURSOR cursor_empleados(salario NUMBER) IS SELECT * FROM employees WHERE salary > salario;
    
    empleado employees%rowtype;
BEGIN
    OPEN cursor_empleados(10000);
    
    LOOP 
        FETCH cursor_empleados INTO empleado;
        EXIT WHEN cursor_empleados%NOTFOUND;
        
        dbms_output.put_line(empleado.first_name || ' ' || empleado.salary);
    END LOOP;
    
    dbms_output.put_line('Número de empleados: ' || cursor_empleados%rowcount || ' ' || 'empleados');
END;
/


/*
    WHERE CURRENT OF
*/


DECLARE
    CURSOR cursor_empleado_actualizar IS SELECT * FROM employees FOR UPDATE;
    
    empleado_actualizar employees%rowtype;
BEGIN
    OPEN cursor_empleado_actualizar;
    
    LOOP
        FETCH cursor_empleado_actualizar INTO empleado_actualizar;
        EXIT WHEN cursor_empleado_actualizar%NOTFOUND;
        
        IF empleado_actualizar.commission_pct IS NOT NULL THEN
            UPDATE employees
                SET salary = salary * 0.10
            -- Fila actual
            WHERE CURRENT OF cursor_empleado_actualizar;
        ELSE
            UPDATE employees
                SET salary = salary * 0.20
            WHERE CURRENT OF cursor_empleado_actualizar;
        END IF;
    END LOOP;
    
    CLOSE cursor_empleado_actualizar;
END;
/


/*
    PRÁCTICA CON CURSORES
*/


/*
    Hacer un programa que tenga un cursor que vaya visualizando los salarios de
    los empleados. Si en el cursor aparece el jefe (Steven King) se debe generar un
    RAISE_APPLICATION_ERROR indicando que el sueldo del jefe no se puede
    ver
*/


DECLARE
    --Declaración de cursor
    CURSOR c_empleados_salarios IS SELECT employee_id, first_name,last_name, salary FROM employees;
    
    --Declaración de la variable
    id_empleado employees.employee_id%type;
    
    jefe_first_name CONSTANT employees.first_name%TYPE := 'Steven';
    jefe_last_name CONSTANT employees.last_name%TYPE := 'King';
BEGIN
    
    -- Obtener el id del empleado
     FOR i IN c_empleados_salarios LOOP
        -- Verificar si el empleado es jefe
        IF i.first_name = jefe_first_name AND i.last_name = jefe_last_name THEN
            -- Generar excepción si es el jefe
            RAISE_APPLICATION_ERROR(-20001,'El sueldo de el jefe no se puede mostrar');
           -- dbms_output.put_line('El sueldo de el jefe no se puede mostrar');

        ELSE
            dbms_output.put_line('id: ' || i.employee_id ||
            ', Nombre completo: ' || i.first_name || ' ' || i.last_name ||
            ', salario: ' || i. salary);
        END IF;
    END LOOP;   
END;
/


/*
    Vamos averiguar cuales son los JEFES (MANAGER_ID) de cada
    departamento. En la tabla DEPARTMENTS figura el MANAGER_ID de cada
    departamento, que a su vez es también un empleado. Hacemos un bloque con
    dos cursores. (Esto se puede hacer fácilmente con una sola SELECT pero vamos
    a hacerlo de esta manera para probar parámetros en cursores).


    El primero de todos los empleados
    o El segundo de departamentos, buscando el MANAGER_ID con el
    parámetro que se le pasa.
    o Por cada fila del primero, abrimos el segundo cursor pasando el
    EMPLOYEE_ID
    o Si el empleado es MANAGER_ID en algún departamento debemos
    pintar el Nombre del departamento y el nombre del MANAGER_ID
    diciendo que es el jefe.
    o Si el empleado no es MANAGER de ningún departamento debemos
    poner “No es jefe de nada”

*/


SET SERVEROUTPUT ON
DECLARE
    --Cursor con todos los empleados
    CURSOR c_empleados IS SELECT * FROM employees;

    --Cursor departamento con el manager_id
    CURSOR c_departamentos(id_manager departments.manager_id%type) IS 
    SELECT * FROM departments 
    WHERE manager_id = id_manager;
    
    -- Variable departamento
    departamento_nombre departments%rowtype;
BEGIN
    -- Ciclo de empleados
    FOR i IN c_empleados LOOP
        -- Abrir el cursor de departamentos
        OPEN c_departamentos(i.employee_id);
        
            FETCH c_departamentos INTO departamento_nombre;
            
            -- Si el cursor encuentra un departamento, el empleado es jefe
            IF c_departamentos%found THEN
                dbms_output.put_line('El empleado ' || i.first_name || ' ' || i.last_name || ' ' || 'es jefe del departamento ' || departamento_nombre.department_name);
            ELSE
                dbms_output.put_line('El empleado ' || i.first_name || ' ' || i.last_name || ', no es jefede nada');
            END IF;
            
        -- Cerrar el cursor de departamentos
        CLOSE c_departamentos;
    END LOOP;
    
END;
/


/*
    -Crear un cursor con parámetros que pasando el número de departamento
    visualice el número de empleados de ese departamento
*/


SET SERVEROUTPUT ON
DECLARE
    CURSOR c_empleados_cantidad(numeroDepartamento employees.department_id%type) IS 
        SELECT count(*) 
        FROM employees 
        WHERE department_id = numeroDepartamento;
    
    mumero_empleado number;
BEGIN
    -- Se le pasa el codigo del departamento
    OPEN c_empleados_cantidad(50);
    LOOP
        FETCH c_empleados_cantidad INTO mumero_empleado;
        
        EXIT WHEN c_empleados_cantidad%NOTFOUND;
        dbms_output.put_line('Cantidad de empleado es: ' || mumero_empleado);
    END LOOP;
END;
/


/*
    Crear un bucle FOR donde declaramos una subconsulta que nos devuelva el
    nombre de los empleados que sean ST_CLERK. Es decir, no declaramos el
    cursor sino que lo indicamos directamente en el FOR.
*/


SET SERVEROUTPUT ON
DECLARE
BEGIN
    FOR i IN (SELECT first_name FROM employees WHERE job_id = 'ST_CLERK') LOOP
        dbms_output.put_line(i.first_name || ' es de ST CLERK');
    END LOOP;
    
END;
/


/*
    -Creamos un bloque que tenga un cursor para empleados. Debemos crearlo con
    FOR UPDATE.
    o Por cada fila recuperada, si el salario es mayor de 8000 incrementamos el
    salario un 2%
    o Si es menor de 8000 lo hacemos en un 3%
    o Debemos modificarlo con la cláusula CURRENT OF
    o Comprobar que los salarios se han modificado correctamente
*/


SET SERVEROUTPUT ON
DECLARE
    -- Declaración del cursor
    CURSOR c_empleado_salario_actualizar IS SELECT salary FROM employees FOR UPDATE;
    
BEGIN
    -- Leer el cursor
    FOR i IN c_empleado_salario_actualizar LOOP
        -- Verificar si el salario es mayor a 800, si es así, hace lo siguiente:
        IF i.salary > 8000 THEN
            UPDATE employees
            SET salary = salary * 1.02
            -- Fila actual
            WHERE CURRENT OF c_empleado_salario_actualizar;
        -- Sino hace lo siguiente:
        ELSE
            UPDATE employees
            SET salary = salary * 1.03
            -- Fila actual
            WHERE CURRENT OF c_empleado_salario_actualizar;
        END IF;
    END LOOP;
    
      -- Confirmar que se han actualizado los salarios
    dbms_output.put_line('Los salarios se han actualizado correctamente.');
END;
/