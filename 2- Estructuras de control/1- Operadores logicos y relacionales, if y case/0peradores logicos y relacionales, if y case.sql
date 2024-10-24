/*
    OPERADORES LOGICOS Y RELACIONALES, IF Y CASE 
*/


/*
    Operadores logicos y relaciones
    
    Operadores relaciones o de comparación
        = (igual a )
        <> (Distinto de)
        < (Menor que)
        > (Mayor que)
        <= (Menor o igual)
        >= (Mayor o igual a)
        
    Operadores lógicos
        AND (Y)
        NOT (Negacion)
        OR (O)
*/


/*
    IF
*/



-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
DECLARE
    x NUMBER := 20;
BEGIN
    -- Comprobando si la variable x es igual a 10
    IF x = 10 THEN
        --Si es verdadero entonces imprime esto:
        dbms_output.put_line('x= 10');
    -- Sino, imprime esto:
    ELSE
        dbms_output.put_line('Otro valor');
    END IF;
END;
/



/*
    PRACTICAS 
*/


-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
DECLARE
    sales NUMBER := 20000;
    bonus NUMBER := 0;
BEGIN
    -- Si la venta es mayor a 50000 el bonus será de 1500
    IF sales > 50000 THEN
        bonus := 1500;
    -- Si la venta es mayor a 35000 el bonus será de 35000
    ELSIF sales > 35000 THEN
        bonus := 500;
    -- Si la venta es mayor a 20000 el bonus será de 150
    ELSIF sales > 20000 THEN
        bonus := 150;
    -- Sino el bonus será de 100
    ELSE
        bonus := 100;
    END IF;

    dbms_output.put_line('Sales:= ' || sales || ', bonus:= ' || bonus);
END;
/


/*
    Debemos hacer un bloque PL/SQL anónimo, donde declaramos una variable 
    NUMBER y la ponemos algún valor.
    • Debe indicar si el número es PAR o IMPAR. Es decir debemos usar IF..... ELSE 
    para hacer el ejercicio
    • Como pista, recuerda que hay una función en SQL denominada MOD, que 
    permite averiguar el resto de una división.
    • Por ejemplo MOD(10,4) nos devuelve el resto de dividir 10 por 4.
*/


-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Declaración de variales
DECLARE
  numero NUMBER := 15;
  resultado NUMBER;
BEGIN
resultado := MOD(numero, 2);

    -- Si da cero es porque el número es par
    IF resultado = 0 THEN
        dbms_output.put_line('Es par');
    -- Sino es impar
    ELSE
        dbms_output.put_line('Es impar');
    END IF;
END;
/


/*
    Crear una variable CHAR(1) denominada TIPO_PRODUCTO.
    • Poner un valor entre "A" Y "E"
    • Visualizar el siguiente resultado según el tipo de producto
    o 'A' --> Electronica
    o 'B' --> Informática
    o 'C' --> Ropa
    o 'D' --> Música
    o 'E' --> Libros
    o Cualquier otro valor debe visualizar "El código es incorr
*/


-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Declaración de variables
DECLARE
    letra CHAR(1);
BEGIN
    -- Inicialización de variables
    letra := 'Q';
    
    IF letra = 'A' THEN
        dbms_output.put_line('Electronica');
    ELSIF letra = 'B' THEN
        dbms_output.put_line('Informatica');
    ELSIF letra = 'C' THEN
        dbms_output.put_line('Ropa');
    ELSIF letra = 'D' THEN
        dbms_output.put_line('Musica');
    ELSIF letra = 'E' THEN
        dbms_output.put_line('LIbros');
    ELSE
        dbms_output.put_line('NO hay informaciÃ²n');
    END IF;
END;
/


--Comparar dos numeros
SET SERVEROUTPUT ON
DECLARE
    numero1 NUMBER;
    numero2 NUMBER;
BEGIN
    numero1 := 5;
    numero2 := 5;
    
    IF numero1 > numero2 THEN
        dbms_output.put_line('Numero1 es mayor porque el valor es de: ' || numero1);
    ELSIF numero2 > numero1 THEN
        dbms_output.put_line('Numero2 es mayor porque el valor es de: ' || numero2);
    ELSE
        dbms_output.put_line('Son numeros iguales');
    END IF;
END;
/



--Verificar si el número es posito y par
SET SERVEROUTPUT ON
DECLARE
    numero NUMBER;
    numeroResultado NUMBER;
BEGIN
    numero:= 1;
    numeroResultado := MOD(numero, 2);
    
    IF numero > 0 AND numeroResultado = 0 THEN
        dbms_output.put_line('El número es positivo y par');
    ELSE -- SOLO ELSE o ELSIF numero < 0 OR numeroResultado <> 0 THEN
        dbms_output.put_line('El número no es positivo y par');
    END IF;
    
END;
/


--Verificar si la edad
SET SERVEROUTPUT ON
DECLARE
    edad NUMBER;
BEGIN
    edad := 65;
    IF edad >= 65 THEN
        dbms_output.put_line('Tercera edad');
    ELSIF edad >= 18 THEN
        dbms_output.put_line('Mayor de edad');
    ELSIF edad >= 0 THEN
        dbms_output.put_line('Menor de edad');    
    END IF;
END;
/


-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON

-- Declaración de variables
DECLARE
    numero1 NUMBER;
    numero2 NUMBER;
BEGIN
    // Inicialización
    numero1 := 30;
    numero2 := 30;
    
    IF numero1 > numero2 THEN
        dbms_output.put_line('Número 1 es mayor que numero 2');
        
    ELSIF numero2 > numero1 THEN
        dbms_output.put_line('Número 2 es mayor que numero 1');
    ELSE
        dbms_output.put_line('Son iguales');
    END IF;
END;
/


/*
    CASE
*/


-- Habilita la salida de mensajes en la consola
SET SERVEROUT ON
-- Declaración de variables
DECLARE
    v1 CHAR(1);
BEGIN
    -- Inicialización de variable
    v1 := 'B';
    
    CASE v1
        -- Si la variable tiene el valor de:    entonces:
        WHEN 'A' THEN dbms_output.put_line('Excellent');
        WHEN 'B' THEN dbms_output.put_line('Very good');
        WHEN 'C' THEN dbms_output.put_line('Good');
        WHEN 'D' THEN dbms_output.put_line('Fair');
        WHEN 'F' THEN dbms_output.put_line('Poor');
        ELSE dbms_output.put_line('No such value');
    END CASE;
END;
/


-- Habilita la salida de mensajes en la consola
SET SERVEROUT ON
DECLARE
    v1 NUMBER;
BEGIN
    -- Inicialización
    v1 := 30;
    
    CASE v1
        WHEN 10 THEN dbms_output.put_line('Excellent');
        WHEN 20 THEN dbms_output.put_line('Very good');
        WHEN 30 THEN dbms_output.put_line('Good');
        WHEN 40 THEN dbms_output.put_line('Fair');
        WHEN 50 THEN dbms_output.put_line('Poor');
        ELSE dbms_output.put_line('No such value');
    END CASE;
END;
/


/*
    SEARCHED CASE
*/


-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Declaración de variable
DECLARE
    bonus number;
BEGIN
    bonus := 100;
    
    CASE
        WHEN bonus > 500 THEN
            dbms_output.put_line('Excellent');
        WHEN bonus <= 500 AND bonus > 250 THEN
            dbms_output.put_line('Very good');
        WHEN bonus <= 250 AND bonus > 100 THEN
            dbms_output.put_line('Good');
        ELSE dbms_output.put_line('POOR...');
    END CASE;
  
END;
/


SET SERVEROUTPUT ON
DECLARE
    nota NUMBER;
BEGIN
    nota:=8;
    
    CASE 
        WHEN nota >= 8 AND nota <=10 THEN dbms_output.put_line('Excelente');
        WHEN nota >=6 AND nota <=7 THEN dbms_output.put_line('Pasable');
        ELSE dbms_output.put_line('NO hay informaciÃ²n');
    END CASE;
    
    
END;
/


SET SERVEROUTPUT ON
DECLARE
    nota NUMBER;
BEGIN
    nota:=5;
    
    CASE nota
        WHEN 10 THEN dbms_output.put_line('Excelente');
        WHEN 5 THEN dbms_output.put_line('Aplazado');
        ELSE dbms_output.put_line('NO hay informaciÃ²n');
    END CASE;
END;
/


/*
    Practica estructura de control
*/


SET SERVEROUTPUT ON
DECLARE
    usuario VARCHAR2(240);
BEGIN
    usuario:= user; --Funcion de oracle que devuelve el user, sin argumentos no es necesario poner parÃ¨ntesis
    
    
    CASE usuario
        WHEN 'SYS' THEN dbms_output.put_line('Eres super administrador');
        WHEN 'SYSTEM' THEN dbms_output.put_line('Eres un admisnitrador normal');
        WHEN 'HR' THEN dbms_output.put_line('Eres de recursos humanos');
        ELSE dbms_output.put_line('Usuario no autorizado');
    END CASE;

END;
/