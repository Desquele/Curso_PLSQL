/*
    BUCLE LOOP, LOOPS ANINADOS, COMANDO CONTINUE, BUCLE FOR, BUCLE WHILE Y COMANDO GOTTO
*/


/*
    BUCLE LOOP
*/


-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Declaración de variables
DECLARE
    x NUMBER :=1;
BEGIN
        -- Inicio del bucle
        LOOP
            dbms_output.put_line(x); -- muestra el valor de x
            x:=x+1; -- Suma +1 en cada iteracción
            --Si x = 11 entonces ejecutame exit, es decir, salir del bucle   
            EXIT WHEN x=11; --Exit Permite salir del bucle
            
        END LOOP;
      
END;
/


/*
    Practica
*/ 


--1: Imprimir números del 1 al 20
-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Declaración de variables
DECLARE
        contador PLS_INTEGER := 0;
BEGIN

    LOOP
        contador := contador + 1;
        dbms_output.put_line(contador);
        
        EXIT WHEN contador = 20;
    END LOOP;
END;
/



--Sumar los primeros 10 números
-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Declaración de variables
DECLARE
    contador PLS_INTEGER:=1;
    suma PLS_INTEGER:=0;
BEGIN
    LOOP
        suma:= suma + contador;
        contador := contador + 1;
        
        EXIT WHEN contador =11;
    END LOOP;
    
    dbms_output.put_line(suma);
END;
/


-- Ejercicio 3: Contar múltiplos de 3 entre 1 y 30
-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Declaración de variables
DECLARE
    contadorBucle PLS_INTEGER := 1;
    contadorMultiplos PLS_INTEGER := 0;
BEGIN
    
    LOOP
    
        --Verifica
        IF MOD(contadorBucle, 3)  = 0 THEN
            contadorMultiplos := contadorMultiplos + 1;
        END IF;
        
        contadorBucle :=contadorBucle + 1;
        EXIT WHEN contadorBucle = 31; 
        
    END LOOP;
    dbms_output.put_line(contadorMUltiplos);
END;
/


/*
    LOOPS ANIDADOS
*/


-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
-- Declaración de variables
DECLARE
    s PLS_INTEGER := 0;
    i PLS_INTEGER := 0;
    j PLS_INTEGER;
BEGIN
    --Etiquetar, SON ETIQUETAS
    << parent >> LOOP
    --Print parent
        i := i + 1;
        j := 100;
        dbms_output.put_line('Parent: ' || i);
        << child >> LOOP
        --Print child
            EXIT parent WHEN ( i > 3 );
            dbms_output.put_line('Child: ' || j);
            j := j + 1;
            EXIT child WHEN ( j > 105 );
        END LOOP child;

    END LOOP parent;
    dbms_output.put_line('FINISH');
END;
/


/*
    CONTINUE
    Es util cuando deseas que, bajo ciertas condiciones, 
    el flujo del bucle se reinicie desde el comienzo, 
    omitiendo el resto de las instrucciones en la iteración actual.
*/


SET SERVEROUTPUT ON
DECLARE
    x NUMBER := 0;
BEGIN
    LOOP
        dbms_output.put_line('Loop: x = ' || to_char(x));
        x := x + 1;
        
        --podemos impedir que siga ejecutando lineas y volvamos al inicio
        --sería omitida si x es menor que 3.
        CONTINUE WHEN x < 3; --Es mejor utilizar esto según la documenntacion
        dbms_output.put_line('Despues de continue: x = ' || to_char(x));
        EXIT WHEN x = 5;
    END LOOP;
END;
/


/*
    Practica continue
*/


/*
    1- Ejercicio 1: Imprimir números pares entre 1 y 20
    Crea un bloque PL/SQL que utilice un bucle para 
    imprimir solo los números pares entre 1 y 20. 
    Usa CONTINUE para saltar los números impares.
*/


SET SERVEROUTPUT ON
DECLARE
    contador NUMBER := 1;
BEGIN
    LOOP
        contador := contador + 1;  -- Incrementar el contador al principio para evitar el bucle infinito
        
        CONTINUE WHEN MOD(contador, 2) != 0;  -- Continuar si es impar
        
        dbms_output.put_line(contador);  -- Imprimir si es par
        
        EXIT WHEN contador > 20;  -- Salir cuando el contador sea mayor que 20
    END LOOP;
END;
/


--Suma de numeros menos multiplos de 3
SET SERVEROUTPUT ON
DECLARE
    x NUMBER := 1;  -- Inicializamos la variable 'x' con valor 1
    suma NUMBER := 0;  -- Variable para acumular la suma de los números
BEGIN
    LOOP
        -- Si x es múltiplo de 3, salta la iteración
        CONTINUE WHEN MOD(x, 3) = 0;
        
        suma := suma + x;  -- Solo suma si x no es múltiplo de 3
        
        x := x + 1;  -- Incrementamos 'x' en 1 para la siguiente iteración
        
        EXIT WHEN x = 11;  -- Detener el bucle cuando 'x' llegue a 11
    END LOOP;
    
    dbms_output.put_line('La suma de los números que no son múltiplos de 3 es: ' || suma);
END;
/


SET SERVEROUTPUT ON
DECLARE
    x NUMBER := 1;
BEGIN
    LOOP
        -- Si x es 5, 7 o 13, salta la iteraciÃ³n
        CONTINUE WHEN x IN (5, 7, 13);
        
        dbms_output.put_line('NÃºmero: ' || x);
        
        x := x + 1;
        
        EXIT WHEN x = 16;  -- Detener el bucle cuando x llegue a 16
    END LOOP;
END;
/


/*
    BUCLE FOR
        - FOR, variable, rango separado por dos puntos
        - Deben de ser numericos (PLS_INTEGER)
        - i solo funciona en el bucle for
*/


-- Habilita la salida de mensajes en la consola
SET SERVEROUTPUT ON
--Declaración de variables
DECLARE
    i varchar(20):= 'des';
BEGIN

    FOR i IN 1..10 LOOP
        dbms_output.put_line(i);   
        EXIT WHEN i = 10; --momento en que i sea igual a 10 se sale
    END LOOP;
    dbms_output.put_line(i);
    
    dbms_output.put_line('REVERSE'); 
    
    FOR i IN REVERSE 1..10 LOOP
        dbms_output.put_line(i);   
    END LOOP;
END;
/


SET SERVEROUTPUT ON
DECLARE
BEGIN
   
   FOR i IN 1..10 LOOP
    dbms_output.put_line(i);
   END LOOP;
   
END;
/


-- 1 Mostrar los números del 1 - 100
SET SERVEROUTPUT ON
BEGIN
    FOR i IN 1..100 LOOP
        dbms_output.put_line(i);
    END LOOP;
END;
/


--   Sumar los números del 1 al 100
SET SERVEROUTPUT ON
DECLARE
    suma NUMBER :=0;
BEGIN
    FOR i IN 1..100 LOOP
        suma := suma + i;
    END LOOP;
    
    dbms_output.put_line(suma);

END;
/

-- 3: Mostrar números pares entre 1 y 20


-- Forma 1:
SET SERVEROUTPUT ON
BEGIN
    FOR i IN 1..20 LOOP
        CONTINUE WHEN MOD(i, 2) != 0; -- va a pasar los numeros  impares para mostrar los pares
        dbms_output.put_line(i);
    END LOOP;
END;
/


-- Forma 2
SET SERVEROUTPUT ON
BEGIN
    FOR i IN 1..20 LOOP
        if MOD(i, 2) = 0   THEN
            dbms_output.put_line(i);
        END IF;
    END LOOP;
END;
/

-- Ejercicio 4: Multiplicaciónn acumulado (1 - 10)
SET SERVEROUTPUT ON
DECLARE
    multiplicador number :=1;
BEGIN
    FOR i IN 1..10 LOOP
        multiplicador := multiplicador * i;
    END LOOP;
    
    dbms_output.put_line('La multiplicaciÃ²n es: ' || multiplicador);
    
END;
/


--Números en orden descendente (20 -1)
SET SERVEROUTPUT ON
BEGIN
    for i IN REVERSE 1..20  LOOP
        dbms_output.put_line(i);
    END LOOP;
END;
/


/*
    Bucle WHILE
    NOs permite realizar un bucle controlado
    "mientras se cumpla la condicion"
*/


SET SERVEROUTPUT ON
DECLARE
    done BOOLEAN := FALSE;
    x NUMBER := 0;
BEGIN
    
    WHILE x < 10 LOOP
        dbms_output.put_line(x);
        x:= x + 1;
        EXIT WHEN x = 5;
    END LOOP;

    WHILE done LOOP
        DBMS_OUTPUT.PUT_LINE('NO imprimas esto.');
        done := TRUE;
    END LOOP;
    
    WHILE NOT done LOOP
        dbms_output.put_line('Ha pasado por aquÃ¬');
        done := true;
    END LOOP;

END;
/


/*
    Practica del PDF
*/


/*
    Practica 1
    Vamos a crear la tabla de multiplicar del 1 al 10, con los tres tipos de
    bucles: LOOP, WHILE y FOR
*/


--Loop
DECLARE
    x NUMBER;
    z NUMBER;
BEGIN
    x := 1;
    z := 1;
    LOOP
        EXIT WHEN x = 11;
        dbms_output.put_line('Tabla de multiplicar del :' || x);
        LOOP
            EXIT WHEN z = 11;
            dbms_output.put_line(x * z);
            z := z + 1;
        END LOOP;

        z := 0;
        x := x + 1;
    END LOOP;

END;
/


-- WHILE
DECLARE
    x NUMBER;
    z NUMBER;
BEGIN
    x := 1;
    z := 1;
    WHILE x < 11 LOOP
        dbms_output.put_line('Tabla de multiplicar del :' || x);
        WHILE z < 11 LOOP
            dbms_output.put_line(x * z);
            z := z + 1;
        END LOOP;

        z := 0;
        x := x + 1;
    END LOOP;

END;
/


BEGIN
    FOR x IN 1..10 LOOP
        dbms_output.put_line('Tabla de multiplicar del :' || x);
        FOR z IN 1..10 LOOP
            dbms_output.put_line(x * z);
        END LOOP;

    END LOOP;
END;
/



/*
    Practica 2:
    Mediante el bucle WHILE escribir la frase al revez
*/


SET SERVEROUTPUT ON
DECLARE
    texto VARCHAR2(25) := 'Hola';
    textoReves VARCHAR2(25);
    tamano PLS_INTEGER;
BEGIN
    tamano := LENGTH(texto);

    WHILE tamano >  0 LOOP
        
        textoReves := textoReves || SUBSTR(texto, tamano,1);
        
        tamano := tamano -1;
    END LOOP;
    
    dbms_output.put_line(textoReves);
END;
/


/*
    Práctica 4
    -   Debemos crear una variable llamada NOMBRE
    -   Debemos pintar tantos asteriscos como letras tenga el nombre.
    -   Usamos un bucle FOR
    -   Por ejemplo Alberto  *******
    -   O por ejemplo Pedro  *****
*/


DECLARE
    nombre     VARCHAR2(100);
    tamanoNombre PLS_INTEGER;
    asteriscos VARCHAR2(100);
BEGIN
    nombre := 'ALBERTO';
    tamanoNombre := length(nombre);
    
    FOR i IN 1..tamanoNombre LOOP
        asteriscos := asteriscos || '*';
    END LOOP;

    dbms_output.put_line(nombre
                         || '-->'
                         || asteriscos);
END;
/


/*
    Practica 5
    
    Creamos dos variables numéricas, "inicio y fin"
    Las inicializamos con algún valor:
    o Debemos sacar los nÃºmeros que sean múltiplos de 4 de ese rango
*/


DECLARE
    inicio NUMBER;
    final  NUMBER;
BEGIN
    inicio := 10;
    final := 200;
    FOR i IN inicio..final LOOP
        IF MOD(i, 4) = 0 THEN
            dbms_output.put_line(i);
        END IF;
    END LOOP;
END;
/
