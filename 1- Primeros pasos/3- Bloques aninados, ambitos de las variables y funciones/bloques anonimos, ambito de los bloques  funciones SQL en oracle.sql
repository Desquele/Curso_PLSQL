/*
    BLOQUES ANIDADOS, ÁMBITO DE LOS BLOQUES Y FUNCIONES SQL EN ORACLE
*/

/*
    Bloques anidados
    Permite agrupar, ordenar trozos de golpes
    es una especie de bloque que se encuentra dentro de otro bloque
    
    Son independientes los bloques hijos heredan cosas del bloque padre pero no al revéz
*/

/*
-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON -- solo una vez, porque es aplicado a todo el bloque

BEGIN
    dbms_output.put_line('Primer bloque, padre');
    DECLARE
        numero1 NUMBER := 4;
    BEGIN
        dbms_output.put_line(numero1);
    END;
END;

*/



/*
    Ámbito de variables en bloques anidados
    "Las variables del bloque padre pueden ser accedidas
        por el bloque hijo pero no al contrario"
        
    Las variables de el bloque hijo no sobreescribe, sino que son variable propias.
*/


/*
-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON

-- Declaración de variables
DECLARE
    x NUMBER := 20; --Variable Global
    z NUMBER := 30; --Variable Global
BEGIN
    dbms_output.put_line('X:= ' || x);
    
    -- Declaración de variables, hija
    DECLARE
        x NUMBER := 10; --Variable Local
        propiaHIjo NUMBER := 16;
    BEGIN
        dbms_output.put_line('X:= ' || x); -- Valor de 10
        dbms_output.put_line('Z:= ' || z);    -- busca en el bloque de el (hija) sino existe busca en el bloque padre    
        dbms_output.put_line('Y:= ' || propiaHIjo);
    END;
    -- Finalización bloque hija
    dbms_output.put_line('Y:= ' || propiaHIjo); -- Da error porque variables del bloque hijo son propias, o puede acceder el padre

END;
*/


/*
    PRACTICA BLOQUES ANIDADOS
*/


/*
    Indicar que valores visualiza X en los 3 casos de
    DBMS_OUTPUT.PUT_LINE(x) en este ejemplo
    
    R// Aparece 10,20, 10 porque el bloque hijo define su propia variable, aunque
    si bien es cierto que se pueden acceder desde el bloque hijo pero este puede
    definir sus propias variables a pesar que sea el mismo nombre, no se sobreescribe porque en este caso fuera del bloque hijo
    si se imprime la variable de nuevo, esta se muestra con el valor que fue dado en el bloque padre.
    
*/
/*
SET SERVEROUTPUT ON

DECLARE
    x NUMBER := 10;
BEGIN
    dbms_output.put_line(x);
    DECLARE
        x NUMBER := 20;
    BEGIN
        dbms_output.put_line(x);
    END;
    dbms_output.put_line(x);
END;
*/

/*
Es este bloque correcto? Si no es así, ¿por qué falla? no es correcto
SET SERVEROUTPUT ON
BEGIN
    dbms_output.put_line(x);
    DECLARE
        x NUMBER := 20;
    BEGIN
        dbms_output.put_line(x);
    END;
    dbms_output.put_line(x);
END;

*/


/*
¿Es este bloque correcto? Si es así ¿qué valores visualiza X?
Si, es correcto porque el bloque hijo está  accediendo a la variable del bloque padre
y recordemos que eso se puede, y visualiza 10 en las tres ocasiones
SET SERVEROUTPUT ON

DECLARE
    x NUMBER := 10;
BEGIN
    dbms_output.put_line(x);
    BEGIN
        dbms_output.put_line(x);
    END;
    dbms_output.put_line(x);
END;

*/





/*
    USO DE FUNCIONES SQL EN PL SQL
    Funciones de SQL se puede utilizar dentro de PLSQL
    estas se utilzan directamente dentro de PLSQL
    
    PERO SOLO SE PUEDEN FUNCIONES SIMPLES
    
    NO SE PUEDE:
        - Funciones de grupo: count, avg, etc.
        - DECODE (especie de case)
*/



/*
-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Declaración de variables
DECLARE
    nombre VARCHAR2(20);
    mayuscula VARCHAR(20);
    fecha DATE;
    numeroDecimal NUMBER:=109.80;
BEGIN
    nombre:= 'Douglas';
    mayuscula:= UPPER(nombre);
    fecha:= SYSDATE;
    
    dbms_output.put_line(SUBSTR(nombre,1, 3));    -- No es la misma función que sql porque se ejecuta dentro de PL/SQL no SQL
    dbms_output.put_line(mayuscula);
    dbms_output.put_line(fecha);
    dbms_output.put_line(ROUND(numeroDecimal, 2));
END;

*/



/*
    PRACTICA FUNCIONES
*/



/*
    Visualizar iniciales de un nombre
    • Crea un bloque PL/SQL con tres variables VARCHAR2: 
    o Nombre
    o apellido1
    o apellido2
    • Debes visualizar las iniciales separadas por puntos.
    • Además siempre en mayúscula
    • Por ejemplo alberto pérez García debería aparecer--> A.P.G
*/
/*
SET SERVEROUTPUT ON
DECLARE
    nombre    VARCHAR2(20);
    apellido1 VARCHAR2(20);
    apellido2 VARCHAR2(20);
    iniciales VARCHAR2(6);
BEGIN
     NOMBRE:='pedro';
     APELLIDO1:='garcia';
     APELLIDO2:='Rodrigiuez';
     
     INICIALES:= SUBSTR(NOMBRE,1,1)||'.'||SUBSTR(APELLIDO1,1,1)|| '.' || substr ( apellido2, 1, 1 ) || '.';
     
     -- Mostrar
     dbms_output.put_line ( upper ( iniciales ) );
END;
*/


/*
    Averiguar el nombre del día que naciste, por ejemplo "Martes"
*/


DECLARE
    fecha_nacimiento    DATE;
    dia_semana VARCHAR2(100);
BEGIN
    fecha_nacimiento := TO_DATE ( '16/11/2001' );
    dia_semana := to_char(fec_nac, 'DAY');
    dbms_output.put_line(dia_semana);
END;