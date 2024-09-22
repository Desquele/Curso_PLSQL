/*
    BOOLEAN, CONSTANTES, OPERADORES
*/

/*
	Boolean
    Existe:
        - TRUE
        - FALSE
        - NULL
*/

/*
-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
--Declaración de variables
DECLARE
    -- Se crea una variable de tipo Boolean
    b1 BOOLEAN;
BEGIN
    -- Inicialización de la variable
    b1:= FALSE;
    b1:= TRUE;
    b1:= NULL;
END;
*/


/*
    %TYPE:
    Permite crear una variable que sea del mismo tipo que la columna
    Se le puede decir que una variable es del mismo tipo que "x" columna
*/


/*

-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Declaración de variables
DECLARE

    numero1 NUMBER:=11;
    numero2 numero1%TYPE:=20;
    --variable     tabla.columna%TYPE
    emplee EMPLOYEES.SALARY%TYPE;
BEGIN
    dbms_output.put_line(numero1);
    dbms_output.put_line(numero2);
END;

*/



/*
    OPERADORES
    
    + SUMA
    - RESTA
    / DIVISIóN
    * MULTIPLICACIÓN
    '' EXPONENTE
    | | CONCATENAR
*/



-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Declaración de variables
DECLARE
    numero1 NUMBER:=0;
    z NUMBER:=5;
    nombre VARCHAR(20):='Douglas';
    fecha DATE:='16/11/2001';
BEGIN

    dbms_output.put_line(nombre  || numero1); -- Concatenar dos cadenas de caracteres
  --  dbms_output.put_line(nombre  + numero1);  -- No se puede utilizar el "+" con una cadena con un número
    dbms_output.put_line(fecha); -- Mostrar la fecha
    dbms_output.put_line(SYSDATE); -- Mostrar fecha actual
    dbms_output.put_line(SYSDATE-fecha); -- Fecha actual menos la fecha de la variable
    dbms_output.put_line(fecha+1); -- Sumar 1 día a la fecha
END;


/*
    PRACTICA ADICIONAL VARIABLES, CONSTANTES Y %TYPE
*/

/*

-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
--Declaración de variables
DECLARE
    impuesto CONSTANT NUMBER:=0.21;
    precioProducto NUMBER(5,2) NOT NULL;
    resultado precioProducto%TYPE;
BEGIN
    --Indicando el precio del producto
    precioProducto:=100;
    
    --Haciendo el proceso
    resultado:= precioProducto * impuesto;
    
    dbms_output.put_line(resultado);
END;

*/
