/*
    
*/

/*
    INTRODUCCI�N A PACKAGES
    Los paquetes en PL/SQL son una forma de agrupar y organizar 
    procedimientos, funciones, variables, y otros objetos relacionados en un solo m�dulo, 
    lo que facilita su gesti�n y reutilizaci�n.
    
    Componentes de un Paquete:
        Specification (SPEC): 
            Es la parte p�blica del paquete donde se declaran los 
            procedimientos, funciones, y variables que estar�n disponibles para 
            otros programas o bloques PL/SQL (Publicas). Solo contiene las definiciones, no el c�digo.
            
        Body (BODY):
            Es la parte privada del paquete donde se define la l�gica de los procedimientos y funciones. 
            Tambi�n puede contener variables y subprogramas que no se exponen fuera del paquete (privados).
*/



/*
    CREAR LAS ESPECIFICACIONES DEL PAQUETE
*/

/*
-- Creamos el paquete
CREATE OR REPLACE PACKAGE ejemplo_package1
IS
    -- Declaraci�n de las variables
    -- Est�n guardados dentro de la sesi�n y queda guardado el valor
    numero1 NUMBER;
    numero2 NUMBER;
END;
/
*/

/*
-- Utilizaci�n del paquete
SET SERVEROUTPUT ON
BEGIN
    -- Inicializaci�n de las variables
    ejemplo_package1.numero1 := 16;
    ejemplo_package1.numero2 := 10;
    
    -- Impresi�n de datos
    dbms_output.put_line(ejemplo_package1.numero1);
    dbms_output.put_line(ejemplo_package1.numero2);

END;
/
*/



/*
    �MBITOS DE LAS VARIABLES
    
    Variables Globales (especificaci�n del paquete): 
        Mantienen su valor entre ejecuciones dentro de la misma sesi�n. 
        Se reinician solo cuando la sesi�n se cierra.

    Variables Privadas (cuerpo del paquete): 
        Solo accesibles dentro del cuerpo del paquete, pero 
        tambi�n retienen su valor durante la sesi�n.

    Al cerrar la sesi�n, todas las variables se reinician a sus valores iniciales.
*/

/*
CREATE OR REPLACE PACKAGE ejemplo_package1_ambito
IS
    -- Declaraci�n de las variables
    -- Est�n guardados dentro de la sesi�n y queda guardado el valor
    numero1 NUMBER := 2;
    numero2 NUMBER;
END;
/
*/

/*
-- Utilizaci�n del paquete
SET SERVEROUTPUT ON
BEGIN
    -- Inicializaci�n de las variables
    ejemplo_package1_ambito.numero1 := ejemplo_package1_ambito.numero1 * 5;
    ejemplo_package1_ambito.numero2 := 10;
    
    -- Impresi�n de datos
    dbms_output.put_line(ejemplo_package1_ambito.numero1);
    dbms_output.put_line(ejemplo_package1_ambito.numero2);

END;
/
*/



/*
    CREAR EL CUERPO DEL PACKAGE
*/

-- Creaci�n del package
/*
CREATE OR REPLACE PACKAGE CONVERSION_PKG 
IS
    -- Declaraci�n del procedimiento almacenado para convertir texto
    PROCEDURE convertir_texto(
        texto VARCHAR2, -- Texto a convertir
        tipo_conversion CHAR
    );
END CONVERSION_PKG;
/
*/

/*
-- Cuerpo del package
CREATE OR REPLACE PACKAGE BODY CONVERSION_PKG
IS
    -- Creaci�n de funci�n para convertir texto a may�sculas
    FUNCTION convertir_a_mayusculas
    (   
        -- Par�metros
        texto VARCHAR2
    )
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN UPPER(texto); -- Convierte el texto en may�sculas
    END convertir_a_mayusculas;
    
    
    -- Creaci�n de funci�n para convertir texto a Min�sculas
    FUNCTION convertir_a_minusculas
    (   
        -- Par�metros
        texto VARCHAR2
    )
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN LOWER(texto); -- Convierte el texto en min�sculas
    END convertir_a_minusculas;
    
    
    -- Procedimiento principal
    PROCEDURE CONVERTIR_TEXTO
    (
        -- Par�metros
        texto VARCHAR2,
        tipo_conversion CHAR
    )
    IS 
    BEGIN
        IF tipo_conversion = 'U'THEN
            dbms_output.put_line(convertir_a_mayusculas(texto));  -- Si el tipo es U, convierte a may�sculas
        ELSIF tipo_conversion = 'L' THEN
            dbms_output.put_line(convertir_a_minusculas(texto));  -- Si el tipo es L, convierte a min�sculas
        ELSE
            dbms_output.put_line('El par�metro debe ser U o L');  -- Si el tipo es diferente, muestra error
        END IF;
    END CONVERTIR_TEXTO;

END CONVERSION_PKG;
/
*/

/*
    UTILIZACI�N
*/

/*
SET SERVEROUTPUT ON
BEGIN 
    -- nombre package. nombre procedimiento
 CONVERSION_PKG.CONVERTIR_TEXTO('Douglas','U');
END;
/
*/











/*
    USAR FUNCIONES DE UN PAQUETE EN COMANDOS SQL
*/

-- Creaci�n del package
/*
CREATE OR REPLACE PACKAGE CONVERSION_PKG_FUNCION
IS
    -- Declaraci�n del procedimiento almacenado para convertir texto
    FUNCTION CONVERTIR_TEXTO(
        texto VARCHAR2, -- Texto a convertir
        tipo_conversion CHAR
    ) RETURN VARCHAR2;
END;
/
*/

/*
-- Cuerpo del package
CREATE OR REPLACE PACKAGE BODY CONVERSION_PKG_FUNCION
IS
    -- Creaci�n de funci�n para convertir texto a may�sculas
    FUNCTION convertir_a_mayusculas
    (   
        -- Par�metros
        texto VARCHAR2
    )
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN UPPER(texto); -- Convierte el texto en may�sculas
    END convertir_a_mayusculas;
    
    
    -- Creaci�n de funci�n para convertir texto a Min�sculas
    FUNCTION convertir_a_minusculas
    (   
        -- Par�metros
        texto VARCHAR2
    )
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN LOWER(texto); -- Convierte el texto en min�sculas
    END convertir_a_minusculas;
    
    
    
    -- Funcion principal
    FUNCTION CONVERTIR_TEXTO
    (
        -- Par�metros
        texto VARCHAR2,
        tipo_conversion CHAR
    )
    RETURN VARCHAR2
    IS 
    BEGIN
        IF tipo_conversion = 'U'THEN
            RETURN(convertir_a_mayusculas(texto));  -- Si el tipo es U, convierte a may�sculas
        ELSIF tipo_conversion = 'L' THEN
            RETURN(convertir_a_minusculas(texto));  -- Si el tipo es L, convierte a min�sculas
        ELSE
            dbms_output.put_line('El par�metro debe ser U o L');  -- Si el tipo es diferente, muestra error
        END IF;
    END CONVERTIR_TEXTO;

END CONVERSION_PKG_FUNCION;
/
*/


/*
    UTILIZACI�N
*/
/*
SET SERVEROUTPUT ON
DECLARE
    texto VARCHAR2(50); 
BEGIN 
    -- nombre package. nombre procedimiento
    texto := CONVERSION_PKG_FUNCION.CONVERTIR_TEXTO('Douglas','U');
    dbms_output.put_line(texto);
END;
/

SELECT
    first_name, CONVERSION_PKG_FUNCION.CONVERTIR_TEXTO(FIRST_NAME, 'U')
FROM
    employees;

*/

/*
    SOBBRECARGA DE PROCEDIMIENTOS
*/











/*
    PRACTICAS
*/


/*
    PRACTICA 1:
    
    Crea un package que permita incrementar el salario de un empleado y consultar su salario actual.

    Package Specification:
    Procedure: incrementar_salario(p_employee_id NUMBER, p_incremento NUMBER)
    Function: consultar_salario(p_employee_id NUMBER) RETURN NUMBER
    
    Package Body:
    El procedimiento debe incrementar el salario de un empleado en un valor proporcionado.
    La funci�n debe devolver el salario actual del empleado.
*/

-- Definic�n del package
/*
CREATE OR REPLACE PACKAGE GESTION_SALARIOS_PKG
IS
    -- Definir el procedimiento
    PROCEDURE P_INCREMENTAR_SALARIO
    (
        p_employee_id NUMBER,
        p_incremento NUMBER
    );
    
    -- Definir la funci�n
    FUNCTION F_CONSULTAR_SALARIO
    (
        p_employee_id NUMBER
    )
    RETURN NUMBER;
END GESTION_SALARIOS_PKG;
/
*/



-- Cuerpo del package
/*
CREATE OR REPLACE PACKAGE BODY GESTION_SALARIOS_PKG
IS

    --PROCEDURE Para incrementar el salario
    PROCEDURE P_INCREMENTAR_SALARIO
        (
            p_employee_id NUMBER,
            p_incremento NUMBER
        )
    IS
        -- Declaraci�n de variables
        p_salario_con_incremento NUMBER;

    BEGIN
        UPDATE EMPLOYEES
        SET 
            salary = salary + (salary * p_incremento/100)
        WHERE 
            employee_id = p_employee_id;
                
        dbms_output.put_line('Incremento actualizado');        
    END P_INCREMENTAR_SALARIO;
    
    
    
    
    -- Funcion para consultar salario actual
    FUNCTION F_CONSULTAR_SALARIO
    (
        p_employee_id NUMBER
    )
    RETURN NUMBER
    IS
        -- Declaraci�n de variables
        salario NUMBER;

    BEGIN
        -- Consulta
        SELECT 
            salary
        INTO 
            salario
        FROM
            employees
        WHERE
            employee_id = p_employee_id;
        
        
        RETURN salario;
    END F_CONSULTAR_SALARIO;

END GESTION_SALARIOS_PKG;
/
*/

/*
    UTILIZACI�N
*/
/*
SET SERVEROUTPUT ON
DECLARE
    employee_id NUMBER;
    aumento NUMBER;
    resultado NUMBER;
BEGIN
    employee_id := 119;
    aumento := 20;
    
    
    -- Aumentar sueldo
    GESTION_SALARIOS_PKG.P_INCREMENTAR_SALARIO(employee_id, aumento);
    
    -- Obtener el sueldo
    resultado := GESTION_SALARIOS_PKG.F_CONSULTAR_SALARIO(employee_id);
    
    dbms_output.put_line(resultado);
END;
/
*/





/*
    Ejercicio 2: Package para gesti�n de departamentos
    Crea un package para la gesti�n de departamentos, que permita 
    agregar un nuevo departamento y contar cu�ntos departamentos existen.
    
    Package Specification:
    Procedure: agregar_departamento(p_nombre VARCHAR2, p_ubicacion_id NUMBER)
    Function: contar_departamentos RETURN NUMBER
    
    Package Body: 
    El procedimiento debe insertar un nuevo departamento con un nombre y una ubicaci�n.
    La funci�n debe devolver la cantidad total de departamentos en la tabla.
*/


-- Definici�n del package
/*
CREATE OR REPLACE PACKAGE GESTION_DEPARTAMENTOS_PKG
IS
    -- Definici�n del procedimiento
    PROCEDURE P_AGREGAR_DEPARTAMENTO
    (
        p_department_id NUMBER,
        p_nombre VARCHAR2,
        p_ubicacion_id NUMBER
    );
    
    -- Definici�n de la funci�n
    FUNCTION F_CONTAR_DEPARTAMENTOS
    RETURN NUMBER;
END GESTION_DEPARTAMENTOS_PKG;
/
*/


-- Cuerpo del package
/*
CREATE OR REPLACE PACKAGE BODY GESTION_DEPARTAMENTOS_PKG
IS
    -- Procedimiento para insertar un departamento
    PROCEDURE P_AGREGAR_DEPARTAMENTO
    (
        p_department_id NUMBER,
        p_nombre VARCHAR2,
        p_ubicacion_id NUMBER
    )
    IS
    BEGIN
        -- Sentencia que inserta un departamento
        INSERT INTO departments(department_id, department_name, location_id) -- falta el department id
        VALUES (p_department_id, p_nombre, p_ubicacion_id);
        
        dbms_output.put_line('Departamento ingresado');
    END P_AGREGAR_DEPARTAMENTO;
    
    -- Funcion para contar departamentos
    FUNCTION F_CONTAR_DEPARTAMENTOS
    RETURN NUMBER
    IS
        -- Declaraci�n de variables
        numero_departamentos NUMBER;
    BEGIN
        SELECT
            COUNT(department_id)
        INTO
            numero_departamentos
        FROM departments;
        
        RETURN numero_departamentos; -- Retornar la variable que contiene el dato
    END F_CONTAR_DEPARTAMENTOS;
    
    
END GESTION_DEPARTAMENTOS_PKG;
/
*/

/*
    UTILIZACI�N
*/
/*
SET SERVEROUTPUT ON
DECLARE
    -- Variables declaraci�n
    departmento_id NUMBER;
    nombre VARCHAR2(25);
    ubicacion_id NUMBER;
    numero_departamento NUMBER;
BEGIN
    
    -- Inicializaci�n
    departmento_id := 280;
    nombre := 'ejemplo';
    ubicacion_id := 1700;
    
    -- Contamos cuando departamentos hay antes de ingresar
    numero_departamento := GESTION_DEPARTAMENTOS_PKG.F_CONTAR_DEPARTAMENTOS;
    dbms_output.put_line(numero_departamento);
    
    -- Ocupando el procedimiento que se encuentra dentro del package
    GESTION_DEPARTAMENTOS_PKG.P_AGREGAR_DEPARTAMENTO(departmento_id, nombre, ubicacion_id);
    
    -- Contamos cuando departamentos hay despues de ingresar
    numero_departamento := GESTION_DEPARTAMENTOS_PKG.F_CONTAR_DEPARTAMENTOS;
    dbms_output.put_line(numero_departamento);

END;
/
*/


/*
    EJERCICIO 3: Package para gesti�n de empleados por departamento
    Crea un package que permita consultar el n�mero de empleados 
    en un departamento y listar sus nombres.
    
    Package Specification:
    Function: numero_empleados_departamento(p_department_id NUMBER) RETURN NUMBER
    Procedure: listar_empleados_departamento(p_department_id NUMBER)

    Package Body:   
    La funci�n debe devolver el n�mero de empleados que pertenecen a un departamento dado.
    El procedimiento debe listar los nombres de los empleados en ese departamento utilizando dbms_output.put_line.
*/

-- Creaci�n del package
/*
CREATE OR REPLACE PACKAGE GESTION_EMPLADOS_DEPARTAMENTO_PKG
IS
    -- Definici�n de la funci�n que contar� el n�mero de empleados por departamento
    FUNCTION F_NUMERO_EMPLEADOS_DEPARTAMENTO
    (
        p_department_id NUMBER
    )
    RETURN NUMBER;
    
    -- Definici�n del procedimiento almacenado que deolver� los empleados por departamento
    PROCEDURE P_LISTAR_EMPLEADOS_DEPARTAMENTO
    (
        p_department_id NUMBER
    );
END;
/
*/


-- Cuerpo del package
/*
CREATE OR REPLACE PACKAGE BODY GESTION_EMPLADOS_DEPARTAMENTO_PKG 
AS

    -- Funci�n que contar� el n�mero de empleados por departamento
    FUNCTION F_NUMERO_EMPLEADOS_DEPARTAMENTO
        (
            p_department_id NUMBER
        )
    RETURN NUMBER 
    AS
        -- Declaraci�n de variables
        cantidad_departamentos NUMBER;
    BEGIN
        -- Sentencia para obtener la cantidad de empleados por el departamento
        SELECT
            COUNT(*)
        INTO
            cantidad_departamentos
        FROM
            employees
        WHERE
            department_id = p_department_id;
            
        RETURN cantidad_departamentos; -- Se retorna la variable con la cantidad
    END F_NUMERO_EMPLEADOS_DEPARTAMENTO;

    -- Procedimiento almacenado que deolver� los empleados por departamento
    PROCEDURE P_LISTAR_EMPLEADOS_DEPARTAMENTO
    (
            p_department_id NUMBER
    ) 
    AS
        -- Declaraci�n del cursor
        CURSOR C_empleados_departamento IS SELECT first_name, last_name FROM employees WHERE department_id = p_department_id;
    BEGIN
        
        -- Leer el cursor
        FOR empleado IN C_empleados_departamento LOOP
            -- Mostrar el nombre completo del empleado
            dbms_output.put_line(empleado.first_name || ' ' || empleado.last_name);
        END LOOP;
    END P_LISTAR_EMPLEADOS_DEPARTAMENTO;

END GESTION_EMPLADOS_DEPARTAMENTO_PKG;
/
*/

/*
    UTILIZACI�N
*/
/*
SET SERVEROUTPUT ON
DECLARE
    departamento_id NUMBER;
    cantidad_empleados NUMBER;
BEGIN
    -- Inicializaci�n de variables
    departamento_id := 90;
    
    cantidad_empleados := GESTION_EMPLADOS_DEPARTAMENTO_PKG.F_NUMERO_EMPLEADOS_DEPARTAMENTO(departamento_id);
    
    dbms_output.put_line('La cantidad de empleados del departamento es: ' || cantidad_empleados);
    
    GESTION_EMPLADOS_DEPARTAMENTO_PKG.P_LISTAR_EMPLEADOS_DEPARTAMENTO(departamento_id);
END;
*/



/*
    SOBRECARGA DE PROCEDIMIENTO
*/
/*
CREATE OR REPLACE PACKAGE SOBRECARGA_PKG
AS
    -- Definici�n de funciones
    FUNCTION F_CONTAR_EMPLEADOS
    (
        id NUMBER
    )
    RETURN NUMBER;
    
    FUNCTION F_CONTAR_EMPLEADOS
    (
        id VARCHAR2
    )
    RETURN NUMBER;
END SOBRECARGA_PKG;
/
*/

/*
CREATE OR REPLACE PACKAGE BODY SOBRECARGA_PKG 
AS

    FUNCTION F_CONTAR_EMPLEADOS
    (
        id NUMBER
    )
    RETURN NUMBER 
    AS
        -- Declaraci�n de variables
        cantidad_empleados NUMBER;
    BEGIN
        
        -- Sentencia para obtener la cantidad de empleados
        SELECT
            COUNT(*)
        INTO
            cantidad_empleados
        FROM 
            employees
        WHERE department_id = id;
        
        RETURN cantidad_empleados; -- Retorna la variable
    END F_CONTAR_EMPLEADOS;


    -- Segunda funci�n
    FUNCTION F_CONTAR_EMPLEADOS
    (
        id VARCHAR2
    )
    RETURN NUMBER 
    AS
        -- Declaraci�n de variable
        cantidad_empleados NUMBER;
    BEGIN
        
    -- Sentencia para obtener la cantidad de empleados
    SELECT 
        COUNT(*)
    INTO 
        cantidad_empleados
    FROM 
        employees e
    JOIN departments d ON (e.department_id = d.department_id)
    WHERE d.department_name = id;

    RETURN cantidad_empleados; -- retorna la cantidad
    END F_CONTAR_EMPLEADOS;

END SOBRECARGA_PKG;
/
*/





/*
    UTILIZANDO
*/
/*
SET SERVEROUTPUT ON
DECLARE
    departamento_id NUMBER;
    departamento_nombre VARCHAR2(50);
BEGIN
    -- Inicializaci�n de variables
    departamento_id := 50;
    departamento_nombre := 'Marketing';
    
    -- Mostrar
    dbms_output.put_line(SOBRECARGA_PKG.F_CONTAR_EMPLEADOS(departamento_id));
END;
*/




/*
    PAQUETES PREDEFINIDOS POR ORACLE
    https://docs.oracle.com/en/database/oracle/oracle-database/19/arpls/DBMS_ALERT.html#GUID-30038E9F-A074-4778-891F-335827E6071A
*/




/*
    PR�CTICAS
*/


/*
    Crear un paquete denominado REGIONES que tenga los 
    siguientes componentes:
    
    PROCEDIMIENTOS:
    - ALTA_REGION, con par�metro de c�digo y nombre Regi�n. 
    Debe devolver un error si la regi�n ya existe. Inserta una nueva 
    regi�n en la tabla. Debe llamar a la funci�n EXISTE_REGION 
    para controlarlo.
    
     - BAJA_REGION, con par�metro de c�digo de regi�n y que 
    debe borrar una regi�n. Debe generar un error si la regi�n no 
    existe, Debe llamar a la funci�n EXISTE_REGION para 
    controlarlo.
    
     - MOD_REGION: se le pasa un c�digo y el nuevo nombre de la 
    regi�n Debe modificar el nombre de una regi�n ya existente. 
    Debe generar un error si la regi�n no existe, Debe llamar a la 
    funci�n EXISTE_REGION para controlarlo.
    
    
    FUNCIONES:
    - CON_REGION. Se le pasa un c�digo de regi�n y devuelve el 
    nombre.
    
    - EXISTE_REGION. Devuelve verdadero si la regi�n existe. Se 
    usa en los procedimientos y por tanto es PRIVADA, no debe 
    aparecer en la especificaci�n del paquete.
    
*/


-- Definici�n del package
/*
CREATE OR REPLACE PACKAGE regiones_pkg IS
    -- Declaraci�n de procedimientos
    
    -- Insertar una regi�n
    PROCEDURE p_agregar_region (
        p_region_id     NUMBER,
        p_region_nombre VARCHAR2
    );
    
    -- Modificar una regi�n
    PROCEDURE p_modificar_region (
        p_region_id     NUMBER,
        p_region_nombre VARCHAR2
    );
    
    
    -- Eliminar una regi�n
    PROCEDURE p_eliminar_region (
        p_region_id NUMBER
    );
    
    -- Declaraci�n de funciones
    
    -- Obtener el nombre de la regi�n
    FUNCTION f_obtener_nombre_region (
        p_region_id NUMBER
    ) RETURN VARCHAR2;

END regiones_pkg;
/
*/


-- Cuerpo del package
/*
CREATE OR REPLACE PACKAGE BODY regiones_pkg IS

    -- Funci�n para verificar si existe la regi�n por nombre
    FUNCTION f_existe_region (
        nombre VARCHAR2
    ) RETURN BOOLEAN IS
        cantidad NUMBER;
    BEGIN
    -- Verifica si la regi�n existe con una consulta directa
        SELECT
            COUNT(*)
        INTO cantidad
        FROM
            regions
        WHERE
            region_name = nombre;

        IF cantidad > 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END f_existe_region;

    
    -- Funci�n para verificar si existe la regi�n por id
    FUNCTION f_existe_region (
        id NUMBER
    ) RETURN BOOLEAN IS
        cantidad NUMBER;
    BEGIN
    -- Verifica si la regi�n existe con una consulta directa
        SELECT
            COUNT(*)
        INTO cantidad
        FROM
            regions
        WHERE
            region_id = id;

        IF cantidad > 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END f_existe_region;

    
    -- Agregar region
    PROCEDURE p_agregar_region (
        -- Declaraci�n de par�metros
        p_region_id     NUMBER,
        p_region_nombre VARCHAR2
    ) IS
    BEGIN 
        -- Si no existe la regi�n se insertar�
        IF f_existe_region(p_region_nombre) = false THEN
            INSERT INTO regions VALUES (
                p_region_id,
                p_region_nombre
            );

            COMMIT;
            dbms_output.put_line('Regi�n insertada');
        ELSE
            dbms_output.put_line('La regi�n ya existe');
        END IF;
    END p_agregar_region;
    
    -- Modificar regi�n
    PROCEDURE p_modificar_region (
        -- Par�metros
        p_region_id     NUMBER,
        p_region_nombre VARCHAR2
    ) IS
    BEGIN 
        -- Si la regi�n existe se actualizar� el nombre
        IF f_existe_region(p_region_id) = true THEN
            UPDATE regions
            SET
                region_name = p_region_nombre
            WHERE
                region_id = p_region_id;

            COMMIT;
            dbms_output.put_line('Regi�n actualizada');
        ELSE
            dbms_output.put_line('Regi�n no est� registrada');
        END IF;
    END p_modificar_region;
    
    -- Eliminar regi�n    
    PROCEDURE p_eliminar_region (
        p_region_id NUMBER
    ) IS
    BEGIN 
        -- Si el if de la regi�n existe se eliminar�
        IF f_existe_region(p_region_id) = true THEN
            DELETE regions
            WHERE
                region_id = p_region_id;

            COMMIT;
            dbms_output.put_line('Regi�n eliminada');
        ELSE
            dbms_output.put_line('Regi�n no est� registrada');
        END IF;
    END p_eliminar_region;
    
    
    -- Funci�n para obtener el nombre de la regi�n
    FUNCTION f_obtener_nombre_region (
        p_region_id NUMBER
    ) RETURN VARCHAR2 IS
        -- Declaraci�n de variables
        nombre_region VARCHAR2(25);
    BEGIN
    
        -- Sentencia para seleccionar el nombre
        SELECT
            region_name
        INTO nombre_region
        FROM
            regions
        WHERE
            region_id = p_region_id;

        RETURN nombre_region;
        dbms_output.put_line('Regi�n incertada');
    END f_obtener_nombre_region;

END regiones_pkg;
/
*/


/*
    UTILIZANDO
*/


/*
SET SERVEROUTPUT ON

DECLARE
    -- Declaraci�n
    nombre_region VARCHAR2(25);
    region_id     NUMBER;
BEGIN
    -- Inicializando
    nombre_region := 'EJEMPLO2';
    region_id := 6;
    
    -- Agregar
    --REGIONES_PKG.P_AGREGAR_REGION(region_id, nombre_region);
    
    -- Actualizar
    regiones_pkg.p_modificar_region(region_id, nombre_region);
    
    -- Eliminar
    --REGIONES_PKG.P_ELIMINAR_REGION(region_id);
    
    --dbms_output.put_line(REGIONES_PKG.F_OBTENER_NOMBRE_REGION(100));
END;
/
*/





/*
    EJERCICIO 2:
    Crear un paquete denominado NOMINA que tenga sobrecargado 
    la funci�n CALCULAR_NOMINA de la siguiente forma:
    
    - CALCULAR_NOMINA(NUMBER): se calcula el salario del 
    empleado restando un 15% de IRPF.
    
    - CALCULAR_NOMINA(NUMBER,NUMBER): el segundo 
    par�metro es el porcentaje a aplicar. Se calcula el salario del 
    empleado restando ese porcentaje al salario
    
    - CALCULAR_NOMINA(NUMBER,NUMBER,CHAR): el segundo 
    par�metro es el porcentaje a aplicar, el tercero vale �V� . Se 
    calcula el salario del empleado aumentando la comisi�n que le 
    pertenece y restando ese porcentaje al salario siempre y 
    cuando el empleado tenga comisi�n.

*/

-- Definici�n del package
/*
CREATE OR REPLACE PACKAGE NOMINA_PKG
IS
    -- Fefinir las funciones
    FUNCTION F_CALCULAR_NOMINA
    (
        p_employee_id NUMBER
    )
    RETURN NUMBER;
    
    
    FUNCTION F_CALCULAR_NOMINA
    (
        p_employee_id NUMBER,
        p_porcentaje_descuento NUMBER
    )
    RETURN NUMBER;

    FUNCTION F_CALCULAR_NOMINA
    (
        p_employee_id NUMBER,
        p_porcentaje_descuento NUMBER,
        p_comision CHAR
    )
    RETURN NUMBER;
END;
/
*/

/*
-- Cuerpo del package
CREATE OR REPLACE PACKAGE BODY NOMINA_PKG AS

    -- Funci�n que verifica la existencia de un empleado
    FUNCTION EXISTE_EMPLEADO
    (
        p_employee_id NUMBER
    )
    RETURN BOOLEAN
    AS
        -- Declaraci�n de variable
        cantidad_empleado NUMBER;
    BEGIN
        -- Si devuelve 1 es porque existe
        SELECT
            COUNT(*)
        INTO
            cantidad_empleado
        FROM
            employees
        WHERE 
            employee_id = p_employee_id;
            
        IF cantidad_empleado > 0 THEN
            RETURN TRUE;
        END IF;
            
    END EXISTE_EMPLEADO;
    
    
    FUNCTION F_CALCULAR_NOMINA
        (
            p_employee_id NUMBER
        )
    RETURN NUMBER 
    AS
        -- Definici�n de variabes
        salario NUMBER;
        salario_con_descuento  NUMBER;
    BEGIN
        
        -- Verificar si existe el empleado
        IF EXISTE_EMPLEADO(p_employee_id) = TRUE THEN
        
            -- Obtener el salario
            SELECT
                salary
            INTO
                salario
            FROM
                employees
            WHERE
                employee_id = p_employee_id;
                
            -- Realizar descuento al salario    
            salario_con_descuento := salario - (salario * 0.15);
        ELSE
            dbms_output.put_line('No existe el empleado');
            
        END IF;
        
        RETURN salario_con_descuento;
    END F_CALCULAR_NOMINA;


    FUNCTION F_CALCULAR_NOMINA
        (
            p_employee_id NUMBER,
            p_porcentaje_descuento NUMBER
        )
    RETURN NUMBER 
    AS
    -- Definici�n de variabes
        salario NUMBER;
        salario_con_descuento  NUMBER;
    BEGIN
        
        -- Verificar si eixte el empleado
        IF EXISTE_EMPLEADO(p_employee_id) = TRUE THEN
        
             -- Obtener el salario
            SELECT
                salary
            INTO
                salario
            FROM
                employees
            WHERE
                employee_id = p_employee_id;
                
            -- Realizar descuento al salario    
            salario_con_descuento := salario - (salario * p_porcentaje_descuento / 100);
            RETURN salario_con_descuento;
        ELSE
            dbms_output.put_line('No existe el empleado');
        END IF;
            
    END F_CALCULAR_NOMINA;


    FUNCTION F_CALCULAR_NOMINA
        (
            p_employee_id NUMBER,
            p_porcentaje_descuento NUMBER,
            p_comision CHAR
        )
    RETURN NUMBER 
    AS
    -- Definici�n de variabes
        salario NUMBER;
        comision NUMBER;
        salario_con_descuento  NUMBER;
    BEGIN
    
        -- Verificar si eixte el empleado
        IF EXISTE_EMPLEADO(p_employee_id) = TRUE THEN
    
            -- Obtener el salario
            SELECT
                salary
            INTO
                salario
            FROM
                employees
            WHERE
                employee_id = p_employee_id;
            
            -- Obtener la comision
            SELECT
                commission_pct
            INTO
                comision
            FROM
                employees
            WHERE
                employee_id = p_employee_id;
                
            
            IF comision IS NOT NULL THEN
                -- Realizar procedimiento al salario    
                salario_con_descuento := salario - (salario * p_porcentaje_descuento/100) + (salario * comision);
                    RETURN salario_con_descuento;
            ELSE
                dbms_output.put_line('No existe comision para el empleado');
                RETURN NULL;
            END IF;
        ELSE
            dbms_output.put_line('No existe el empleado');
            RETURN NULL;
        END IF;
                
    END F_CALCULAR_NOMINA;

END NOMINA_PKG;
/


/*
    UTILIZANDO
*/
/*
SET SERVEROUTPUT ON
DECLARE
    -- Declaraci�n de variables
    empleado_id NUMBER;
    descuento NUMBER;
    
BEGIN
    -- Inicializaci�n de variables
    empleado_id := 164;
    descuento := 25;
    
    -- Mostrando
    --dbms_output.put_line(NOMINA_PKG.F_CALCULAR_NOMINA(101));
    --dbms_output.put_line(NOMINA_PKG.F_CALCULAR_NOMINA(empleado_id, descuento));
    dbms_output.put_line(NOMINA_PKG.F_CALCULAR_NOMINA(empleado_id, descuento, 'D'));
END;
/
*/
