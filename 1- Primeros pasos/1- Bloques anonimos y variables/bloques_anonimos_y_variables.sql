/*
    Bloques anónimos
*/


-- Imprimir un número
BEGIN
    -- Imprimir el número 4
    dbms_output.put_line(4);
END;
/


-- Imprimir cadenas de textos y números


-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
BEGIN
    -- Impresión por consola
    dbms_output.put_line(4);
    dbms_output.put_line('Douglas Quele');
    dbms_output.put_line('Douglas' || 'Quele');
END;
/


-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
BEGIN
    -- Concatenar dos cadenas de texto
    dbms_output.put_line('DOUGLAS' || ' QUELE');
    dbms_output.put_line(19);

END;
/


/*
	Variables
*/


-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Acá declaramos variables
DECLARE
    IVA NUMBER:=10;
BEGIN
    -- Impresión de el valor de la variable IVA
    dbms_output.put_line(IVA);
END;
/


--CONSTANT AND NOT NULL

--sino se inicializa la variable hagarra el valor de null

-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Donde se declarán las variables
DECLARE
    -- CONSTANT
    IVA CONSTANT NUMBER:=13.5; -- NO se puede cambiar
    
    -- NOT NULL
    numero NUMBER NOT NULL:=10; -- No puede estar vacio, puede cambiar el valor
BEGIN

    -- Impresión de valores de las variables
    dbms_output.put_line(IVA);
    dbms_output.put_line(numero);

    numero:=16;
    dbms_output.put_line(numero);
END;
/


/*
    Practica de Variables
*/


/*
    Crear dos variables de tipo numérico y visualizar su suma
*/


-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Declaración de variables
DECLARE
    numero1  NUMBER:=10;
    numero2  NUMBER NULL:=5;
    resultado NUMBER;
BEGIN
    resultado := numero1 + numero2;
    dbms_output.put_line(resultado);
END;
/


/*
    Modificar el ejemplo anterior y ponemos null como valor de una de las 
    variables. ¿Qué resultado arroja? Volvemos a ponerla un valor numérico
*/


-- Cualquier operación que lleve un null devuelve un null
-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
DECLARE
    numero1  NUMBER:=10;
    numero2  NUMBER:=NULL;
    numero3 CONSTANT NUMBER:=12;
    resultado NUMBER;
BEGIN
    resultado := numero1 + numero3;
    dbms_output.put_line(resultado);
END;
/


/*
    Crear un bloque anónimo que tenga una variable de tipo VARCHAR2 con 
    nuestro nombre, otra numérica con la edad y una tercera con la fecha de 
    nacimiento. Visualizarlas por separado y luego intentar concatenarlas. ¿es 
    posible?
*/


SET SERVEROUTPUT ON
DECLARE
    nombre VARCHAR2(100):= 'Douglas';
    edad NUMBER;
    fechaNacimiento DATE;
BEGIN
    edad := 22;
    fechaNacimiento := '16/11/2001';

    dbms_output.put_line(nombre);
    dbms_output.put_line(edad);
    dbms_output.put_line(fechaNacimiento);
END;
/
