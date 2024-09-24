/*
    ARRAYS ASOCIATIVOS, SELECTS MULTIPLES CON ARRAYS ASOCIATIVOS
*/

/*
    Colecciones y tipos compuestos: Almacenan objetos del mismo tipo, parecido a los arrays
 
    Arrays asociativos: Associative arrays (INDEX BY tables)
    - Son colecciones pl/SQL con dos columnas
    - Clave primaria de tipo entero o cadena
    - Valores: un tipo que puede ser escalar o record
    
    codigo | value
    
    SINTAXIS:
    TYPE nombre_array IS TABLE OF
         tipo de datos que almacenerá el array
    (Indica que los indices serán cadenas de texto)
    INDEX BY VARCHAR2 INDEX BY PLS_INTEGER | BINARY INTEGER | VARCHAR2(x);
        
    --Creacion de variables
    nombreVariable nombre_array;
    
    --Tipo simple
    PARA ACCEDER AL ARRAY
    nombre_array(N) "N -> Posicion" son dinamicos
    
    --Inicialización
    nombre_array(num) := 'contenido';
    nombre_array(num) := 'contenido';
    
    --Imprimir
    dbms_output.put_line(nombre_array(num));
   
    -- TIPO COMPUESTO
    nombre_array(N).campo
    
    SELECT 
        *
    INTO array(1)
    FROM tabla
    WHERE campo = num;
    
    --Imprimir
    dbms_output.put_line(array(1).campo);
    

    METODOS:
    EXISTS (N): DETECTAR SI EXISTE UN ELEMENTO
    COUNT: NÚMERO DE ELEMENTOS
    FIRST: DEVUELVE EL ÍNDICE MÁS PEQUEÑO
    LAST: DEVUELVE EL ÍNDICE MÁS ALTO
    PRIOR(N): DEVUELVE EL ÍNDICE ANTERIOR A N
    NEXT(N): DEVUELVE EL ÍNDICE POSTERIOR A N
    DELETE: BORRA TODO
    DELETE(N): BORRAR EL ÍNDICE N
    DELETE(M,N): BORRA DE LOS ÍNDICES M A N
    
    ejemplo:
    DBMS_OUTPUT.PUT_LINE(DEPTS.LAST);
    DBMS_OUTPUT.PUT_LINE(DEPTS.FIRST);
    IF DEPTS.EXISTS(3 THEN 
        DBMS_OUTPUT.PUT_LINE(DEPTS(3)); 
    ELSE
        DBMS_OUTPUT.PUT_LINE('ESE VALOR NO EXISTE'); 
    END IF;
*/




/*
    Trabajar con arrays asociativos
*/


/*
SET SERVEROUTPUT ON 
DECLARE
    --Declaración de Arrays
    
    -- Tipo simple
    TYPE departamentos_arrays IS
        TABLE OF departments.department_name%TYPE 
    INDEX BY PLS_INTEGER;
    
    -- Tipo compuesto
    TYPE empleados_arrays IS
        TABLE OF employees%ROWTYPE
    INDEX BY PLS_INTEGER;    
    
    -- Creación de variables
    
    -- Tipo simple
    departamentos departamentos_arrays;
    
    -- Tipo complejo
    empleados empleados_arrays;
BEGIN
    
        -- Tipo simple
    
    -- Inicializacion del array departamentos
    departamentos(1) := 'Informatica';
    departamentos(2) := 'Recursos humanos';
    
    -- Impresion de datos
    dbms_output.put_line(departamentos(1));
    dbms_output.put_line(departamentos(2));
    
    --Métodos
    dbms_output.put_line(departamentos.LAST); -- Trae el ultimo
    dbms_output.put_line(departamentos.FIRST); -- Trae el primero
    
    IF departamentos.EXISTS(3) THEN 
        dbms_output.put_line (departamentos(3)); 
    ELSE
        dbms_output.put_line('ESE VALOR NO EXISTE'); 
    END IF;
    
    
       -- Tipo complejo
    
    SELECT 
        *
    INTO empleados(1) 
    FROM EMPLOYEES
    WHERE employee_id = 100;
    
    dbms_output.put_line(empleados(1).first_name);
    
    SELECT 
        *
    INTO empleados(2) 
    FROM EMPLOYEES
    WHERE employee_id = 101;
    
    dbms_output.put_line(empleados(2).first_name);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLCODE);
        dbms_output.put_line(SQLERRM);
END;
*/




/*
    Practica
*/

/*
    Ejercicio 1:
    1. Crea un array asociativo de tipo NUMBER con índices VARCHAR2.
    2. Agrega varios elementos al array con diferentes índices.
    3. Usa el método EXISTS para verificar si un índice específico está presente en el array.
    4. Usa el método COUNT para obtener el número total de elementos en el array.
    5. Muestra los resultados usando DBMS_OUTPUT.PUT_LINE.
       
*/
/*
SET SERVEROUTPUT ON
DECLARE
    --Creación del array
    TYPE array_asociativo 
    -- OF number -> tipo de datos que almacenerá el array
    IS TABLE OF NUMBER 
    -- INDEX BY VARCHAR2(Indica que los indices serán cadenas de texto)
    INDEX BY VARCHAR2(50);
    
    --Variale
    numeros array_asociativo ;
BEGIN
    -- Agregando elementos al array
    numeros('A') := 1;
    numeros('B') := 2;
    numeros('C') := 3;
    numeros('D') := 4;
    
    --Verificar que si un indice específico está presente en el array
    IF numeros.exists('A') THEN
        dbms_output.put_line('Si existe');
    END IF;
    
    --Mostrar la cantidad de elementos en el array
    dbms_output.put_line(numeros.count);
END;
*/


/*
    Ejercicio 2:
    1. Crea un array asociativo de tipo VARCHAR2 con índices NUMBER.
    2. Agrega varios elementos al array con diferentes índices.
    3. Usa los métodos FIRST, LAST, PRIOR, y NEXT para recorrer los índices del array y mostrar los valores correspondientes.
*/
/*
SET SERVEROUT ON
DECLARE
    -- Creación del array
    TYPE arrayVarchar IS TABLE OF VARCHAR2(25)
    INDEX BY PLS_INTEGER;
    
    --Creación de la variable
    cadena arrayVarchar;
    
    idx NUMBER;
BEGIN
    --Agregar elementos al array
    cadena(1) := 'Hola';
    cadena(2) := 'Bienvenido';
    cadena(3) := 'Diviertete';
    
    --Impresión de resultados
    dbms_output.put_line(cadena.first); -- Muestra el primer indice
    dbms_output.put_line(cadena.last); -- Muestra el último indice
    --dbms_output.put_line(cadena.prior);
    --dbms_output.put_line(cadena.first);
  
  dbms_output.put_line('-----------------');
  
  -- Mostrar el indice y el valor
    idx := cadena.FIRST;
    WHILE idx IS NOT NULL LOOP
        dbms_output.put_line('Índice: ' || idx || ', Valor: ' || cadena(idx));
        idx := cadena.NEXT(idx);
    END LOOP;
END;
*/


/*
    Ejercicio 3:
    1. Crea un array asociativo de tipo NUMBER con índices NUMBER.
    2. Agrega varios elementos al array.
    3. Usa el método DELETE para borrar un índice específico.
    4. Usa el método DELETE sin parámetros para borrar todos los elementos.
    5. Muestra el número de elementos después de cada operación para verificar los cambios.
*/
/*
SET SERVEROUTPUT ON
DECLARE
    -- Creación del array
    TYPE array_numerico IS TABLE OF NUMBER
    INDEX BY PLS_INTEGER;
    
    -- Creación de variable
    numeros array_numerico;
    
    indice NUMBER;
BEGIN
    --Agregar elementos
    numeros(1) := 1;
    numeros(2) := 2;
    numeros(3) := 3;
    numeros(4) := 4;
    
    dbms_output.put_line('Elementos del array');
    
    --Bucle que muestre todos los elementos
    indice := numeros.first;
    WHILE indice IS NOT NULL LOOP
        dbms_output.put_line(numeros(indice));
        
        indice := numeros.next(indice);
    END LOOP;
    
    -- Eliminar un índice en especifico
    numeros.DELETE(1);
    
    -- mostrar
    dbms_output.put_line('Elementos despues de borrar uno en especifico');
   
    indice := numeros.first;
    WHILE indice IS NOT NULL LOOP
        dbms_output.put_line(numeros(indice));
        
        indice := numeros.next(indice);
    END LOOP;
    
    -- Borrar indices del 2 al 4
    numeros.DELETE(2, 4);
    -- mostrar
    dbms_output.put_line('Elementos despues de borrar el indice del 2 al 4');
   
    indice := numeros.first;
    WHILE indice IS NOT NULL LOOP
        dbms_output.put_line(numeros(indice));
        
        indice := numeros.next(indice);
    END LOOP;
    
    
    -- Eliminar todo

    numeros.DELETE;
    
    -- mostrar
    dbms_output.put_line('Arrays sin elementos');
 
    indice := numeros.first;
    WHILE indice IS NOT NULL LOOP
        dbms_output.put_line(numeros(indice));
        
        indice := numeros.next(indice);
    END LOOP;
END;

*/



/*
    Falta hacer lo del 82
*/




/*
    Practica de Colecciones y Registros
    
    • Creamos un TYPE RECORD que tenga las siguientes columnas
    
    NAME VARCHAR2(100),
    SAL EMPLOYEES.SALARY%TYPE,
    COD_DEPT EMPLOYEES.DEPARTMENT_ID%TYPE);
    
    Creamos un TYPE TABLE basado en el RECORD anterior
    • Mediante un bucle cargamos en la colección los empleados. El campo NAME
    debe contener FIRST_NAME y LAST_NAME concatenado.
    • Para cargar las filas y siguiendo un ejemplo parecido que hemos visto en el
    vídeo usamos el EMPLOYEE_ID que va de 100 a 206
    
    A partir de este momento y ya con la colección cargada, hacemos las siguientes
    operaciones, usando métodos de la colección.
    
    Visualizamos toda la colección
    • Visualizamos el primer empleado
    • Visualizamos el último empleado
    • Visualizamos el número de empleados
    • Borramos los empleados que ganan menos de 7000 y visualizamos de
    nuevo la colección
    • Volvemos a visualizar el número de empleados para ver cuantos se han
    borrado
*/

SET SERVEROUT ON
DECLARE

    --Creación del record
    TYPE empleado_record IS RECORD(
        nombre varchar2(25),
        salario employees.salary%TYPE,
        codigo_departamento employees.department_id%TYPE
    );
    
    -- Creación del array
    TYPE empleadoArrays IS TABLE OF
        empleado_record
    INDEX BY PLS_INTEGER;
    
    --Variables
    empleados empleadoArrays;
    
    id_employee_menor employees.employee_id%TYPE;
    id_employee_mayor employees.employee_id%TYPE;
    
BEGIN

 --Obtener el id del empleado menor
    SELECT MIN(EMPLOYEE_ID)
    INTO id_employee_menor
    FROM EMPLOYEES;
    
    -- Obtener el id del empleado mayor
    SELECT MAX(EMPLOYEE_ID)
    INTO id_employee_mayor
    FROM EMPLOYEES;
    
        
    -- Mediante un bucle cargamos en la colección los empleados. El campo NAME
    -- debe contener FIRST_NAME y LAST_NAME concatenado.
    FOR i IN id_employee_menor..id_employee_mayor LOOP
        SELECT 
            FIRST_NAME ||' '||
            LAST_NAME,
            SALARY,
            DEPARTMENT_ID
        INTO empleados(i)
        FROM EMPLOYEES
        WHERE employee_id = i;
    END LOOP; 
    
    -- Visualizar toda la colección:

    FOR i IN empleados.first..empleados.last LOOP
        dbms_output.put_line(empleados(i).nombre || ' ' || empleados(i).salario || empleados(i).codigo_departamento);
    END LOOP;
        
    -- Visualizar el primer empleado
    dbms_output.put_line(empleados(empleados.first).nombre || ' ' ||
    empleados(empleados.first).salario || ' ' || empleados(empleados.first).codigo_departamento);
       
    -- Visualizar el ultimo empleado
    dbms_output.put_line(empleados(empleados.last).nombre || ' ' ||
    empleados(empleados.last).salario || ' ' || empleados(empleados.last).codigo_departamento);
   
       
    -- Visualizar el número de empleados
    dbms_output.put_line(empleados.count);

    -- Borramos los empleados que ganan menos de 7000 y visualizamos de
    -- nuevo la colección, empleados.salary < 7000
    FOR i IN empleados.first..empleados.last LOOP
        IF empleados(i).salario < 7000 THEN
            empleados.delete(i);
        END IF;
    END LOOP;
   
     
    -- Visualización
     FOR i IN empleados.FIRST..empleados.LAST LOOP
        dbms_output.put_line(empleados(i).nombre || ' ' || empleados(i).salario || empleados(i).codigo_departamento);
    END LOOP;
    
     -- Visualizar el número de empleados
    dbms_output.put_line(empleados.count);
    
END;
/

