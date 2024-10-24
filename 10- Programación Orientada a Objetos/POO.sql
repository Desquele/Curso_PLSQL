/*
    PROGRAMACI�N ORIENTADO A OBJETOS
*/

/*
    CREACI�N DE OBJETO
*/

/*
    1. DECLARACI�N
*/
CREATE OR REPLACE TYPE PRODUCTO
AS OBJECT(
    
    -- Declaraci�n de atributos
    codigo NUMBER,
    nombre varchar2(25),
    precio NUMBER,
    
    -- M�todos
    MEMBER FUNCTION ver_producto RETURN VARCHAR2,
    MEMBER PROCEDURE cambiar_precio (precio NUMBER),
    MEMBER FUNCTION ver_precio RETURN NUMBER, -- Funci�n sin par�metros
    MEMBER FUNCTION ver_precio(impuestos NUMBER) RETURN NUMBER, -- Funci�n con par�metro
    
    
    -- Constructor
    CONSTRUCTOR FUNCTION PRODUCTO(p_nombre VARCHAR2) RETURN SELF AS RESULT
) NOT FINAL; -- PERMITE LA HERENCIA
/


/*
    2. CUERPO
*/


-- Crear una secuencia que se utilizar� en el codigo
CREATE SEQUENCE sequencia_1;

CREATE OR REPLACE TYPE BODY PRODUCTO
AS
    -- Constructor
    CONSTRUCTOR FUNCTION PRODUCTO(p_nombre VARCHAR2)
    RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.codigo := sequencia_1.nextval;
        SELF.PRECIO := NULL;
        SELF.nombre := p_nombre;
        
        RETURN;
    END;

    -- M�todo para ver el producto
    MEMBER FUNCTION ver_producto
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN 'C�digo: ' || codigo || ', nombre: ' || nombre || ', precio: ' || precio;
    END ver_producto;
    
    -- M�todo para ver el precio del producto
    MEMBER FUNCTION ver_precio
    RETURN NUMBER
    AS
    BEGIN
        RETURN precio;
    END ver_precio;
    
    -- M�todo para ver el precio con impuestos (sobrecarga)
    MEMBER FUNCTION ver_precio(impuestos NUMBER)
    RETURN NUMBER
    AS
    BEGIN
        RETURN precio - precio * impuestos / 100;
    END ver_precio; 
 
 
    -- M�todo para cambiar precio
    MEMBER PROCEDURE cambiar_precio(precio NUMBER)
    AS
    BEGIN
        -- self para referirse a la instancia actual
        SELF.precio := precio;
    END cambiar_precio;
    
END;
/


/*
    UTILIZACI�N
*/

SET SERVEROUTPUT ON
DECLARE
    -- Declaraci�n de la variable
    producto1 producto;
    producto2 producto;
    producto3 producto;
BEGIN
    -- Creaci�n de la variable
    producto1 := producto(01, 'Telefono Samsung', 300);
    
    -- Ver el producto
    dbms_output.put_line(producto1.ver_producto());
    
    -- Ver el precio
    dbms_output.put_line(producto1.ver_precio());
     
    -- Ver precio, sobrecarga
    dbms_output.put_line(producto1.ver_precio(50));

     
    -- Cambiar el precio
    producto1.cambiar_precio(350);
    dbms_output.put_line(producto1.ver_producto);
    
    -- Cambiar nombre
    producto1.nombre := 'Telefono Samsung 2';
    dbms_output.put_line(producto1.ver_producto());

    dbms_output.put_line('------ PROBANDO EL CONSTRUCTOR ------');
    
    producto2 := PRODUCTO('Guineo');
    dbms_output.put_line(producto2.ver_producto());

    producto3 := PRODUCTO('Reloj');
    dbms_output.put_line(producto3.ver_producto());
    
END;
/


/*
    M�TODOS ESTATICOS
    No dependen de una instancia espec�fica del objeto y se pueden invocar 
    sin necesidad de crear un objeto de esa clase. Estos m�todos est�n asociados 
    con el tipo de objeto en s� mismo, en lugar de con una instancia espec�fica.
*/


-- Definir un tipo de objeto con un m�todo est�tico
CREATE OR REPLACE TYPE PRODUCTO_ESTATICO AS OBJECT (
    
    -- Variables
    codigo NUMBER,
    nombre VARCHAR2(25),
    precio NUMBER,

    -- M�todos miembro
    MEMBER FUNCTION ver_producto RETURN VARCHAR2,
    MEMBER FUNCTION ver_precio RETURN NUMBER,
    MEMBER PROCEDURE cambiar_precio (precio NUMBER),
    
    -- M�todo est�tico
    STATIC FUNCTION calcular_descuento(precio NUMBER, porcentaje NUMBER) RETURN NUMBER
);
/

-- Definir el cuerpo del tipo de objeto
CREATE OR REPLACE TYPE BODY PRODUCTO_ESTATICO AS

    -- M�todo para ver el producto
    MEMBER FUNCTION ver_producto 
    RETURN VARCHAR2 
    AS
    BEGIN
        RETURN 'C�digo: ' || codigo || ', nombre: ' || nombre || ', precio: ' || precio;
    END ver_producto;

    -- M�todo para ver el precio del producto
    MEMBER FUNCTION ver_precio RETURN NUMBER AS
    BEGIN
        RETURN precio;
    END ver_precio;

    -- M�todo para cambiar precio
    MEMBER PROCEDURE cambiar_precio(precio NUMBER) AS
    BEGIN
        SELF.precio := precio;
    END cambiar_precio;

    -- M�todo est�tico para calcular descuento
    STATIC FUNCTION calcular_descuento(precio NUMBER, porcentaje NUMBER) 
    RETURN NUMBER AS
    BEGIN
        RETURN precio - (precio * porcentaje / 100);
    END calcular_descuento;
END;
/


-- Utilizaci�n del m�todo est�tico
DECLARE
    precio_original NUMBER := 100;
    precio_con_descuento NUMBER;
BEGIN
    -- Llamada al m�todo est�tico sin necesidad de crear una instancia
    precio_con_descuento := PRODUCTO.calcular_descuento(precio_original, 10);
    DBMS_OUTPUT.PUT_LINE('Precio con descuento: ' || precio_con_descuento);
END;
/


/*
    MINI PR�CTICA
*/


/*
    EJERCICIO 1:
    
    Crear un m�todo est�tico para calcular impuestos sobre el precio
    INSTRUCCIONES:
        1. Define el objeto PRODUCTO con los siguientes atributos: 
        codigo, nombre y precio.
        
        2. Crea un m�todo miembro llamado ver_producto que retorne 
        una cadena con la descripci�n del producto.
        
        3. Define un m�todo est�tico llamado calcular_impuesto que acepte 
        un precio como par�metro y retorne el 15% de ese precio como impuesto.
        
        4. Crea una instancia de PRODUCTO, utiliza el m�todo miembro para 
        ver los detalles del producto y llama al m�todo est�tico para calcular el impuesto sobre su precio.
*/

-- Definicion
CREATE OR REPLACE TYPE PRODUCTO_ESTATICO AS OBJECT(
    -- Atributos
    codigo VARCHAR2(100),
    nombre VARCHAR2(100),
    precio NUMBER,
    
    -- M�todo
    MEMBER FUNCTION ver_producto RETURN VARCHAR2,
    
    -- M�todo estatico
    STATIC FUNCTION  calcular_impuesto(precio NUMBER) RETURN NUMBER
);
/
-- Cuerpo
CREATE OR REPLACE TYPE BODY PRODUCTO_ESTATICO AS
    
    -- M�todo para ver el producto
    MEMBER FUNCTION ver_producto
    RETURN VARCHAR2
    AS
    BEGIN 
        RETURN 'C�digo: ' || codigo || ', nombre: ' || ', precio: ' || precio;
    END;
    
    -- M�todo estatico para calcular el impuesto
    STATIC FUNCTION calcular_impuesto( precio NUMBER)
    RETURN NUMBER
    AS
        impuesto NUMBER := 15;
    BEGIN
        RETURN precio * impuesto / 100;
    END;
    
END;
/

/*
    UTILIZACI�N
*/
SET SERVEROUTPUT ON
DECLARE
    -- Declaraci�n
    producto1 producto_estatico;
BEGIN
    -- Creaci�n
    producto1 := producto_estatico(100, 'Botella', 15);
    
    dbms_output.put_line(producto1.ver_producto);
END;
/



/*
    EJERCICIO 2:
    INSTRUCCIONES:
        1. Define el objeto PRODUCTO con los atributos codigo, nombre, y precio.
        2. Crea un m�todo est�tico llamado validar_precio que acepte un precio como par�metro y levante un error si el precio es menor o igual a cero.
        3. Crea un m�todo miembro llamado asignar_precio que llame al m�todo est�tico validar_precio antes de asignar el precio al producto.
        4. Crea una instancia de PRODUCTO e intenta asignarle un precio negativo para verificar que el error es levantado correctamente. 
*/

-- Definici�n
CREATE OR REPLACE TYPE PRODUCTO AS OBJECT(
    -- Atributos
    codigo NUMBER,
    nombre VARCHAR2(50),
    precio NUMBER,
    
    -- M�todo est�tico
    STATIC PROCEDURE VALIDAR_PRECIO(precio NUMBER),
    
    -- M�todo miembro
    MEMBER PROCEDURE ASIGNAR_PRECIO(p_precio NUMBER),
    
    MEMBER FUNCTION VER_PRODUCTO RETURN VARCHAR2

);
/


-- Cuerpo
CREATE OR REPLACE TYPE BODY PRODUCTO
AS
    -- Validar el precio
    STATIC PROCEDURE VALIDAR_PRECIO (precio NUMBER)
    AS
    BEGIN
        IF precio <=0 THEN
            RAISE_APPLICATION_ERROR(-20005, 'El precio no debe de ser menor o igual a cero');
        END IF;
    END VALIDAR_PRECIO;
    
    -- Asignar precio
    MEMBER PROCEDURE ASIGNAR_PRECIO(p_precio NUMBER)
    AS
    BEGIN
        PRODUCTO.VALIDAR_PRECIO(p_precio);
        precio := p_precio;
    END ASIGNAR_PRECIO;
    
    -- Mostrar informaci�n del producto
    MEMBER FUNCTION VER_PRODUCTO
    RETURN VARCHAR2
    AS
    BEGIN
        RETURN 'C�digo: ' || codigo || ', nombre: ' || nombre || ', precio: ' || precio;
    END VER_PRODUCTO;
END;
/


/*
    UTILIZACI�N
*/

SET SERVEROUTPUT ON
DECLARE
    telefono producto;
BEGIN
    telefono := PRODUCTO(1, 'Samsung', null);
    
    -- Mostrar producto
    dbms_output.put_line(telefono.VER_PRODUCTO);
    
    -- Asignar nombre
    telefono.asignar_precio(0);

    -- Mostrar producto
    dbms_output.put_line(telefono.VER_PRODUCTO);
END;
/


/*
    COMPROBAR LOS OBJETOS QUE TENEMOS
*/


DESC PRODUCTO;
SELECT * FROM USER_TYPES;

-- Ver el codigo fuente
SELECT * FROM USER_SOURCE WHERE NAME = 'PRODUCTO';

SELECT TEXT FROM USER_SOURCE WHERE NAME = 'PRODUCTO';



/*
    HERENCIA
    
    Se usa la Cl�usula UNDER para que sea heredable,
    el objeto o m�todo debe ser "NOT FINAL"
*/

CREATE OR REPLACE TYPE COMESTIBLES UNDER PRODUCTO(
    -- VARIABLES
    caducidad DATE,
    
    -- Funciones
    MEMBER FUNCTION VER_CADUCIDAD RETURN VARCHAR2,
    -- Sobre escribir
    OVERRIDING MEMBER FUNCTION ver_precio RETURN NUMBER -- Sobre escritura
);
/


CREATE OR REPLACE TYPE BODY COMESTIBLES
AS
    -- Funciones
    MEMBER FUNCTION ver_caducidad 
    RETURN VARCHAR2
    AS
    BEGIN
        return caducidad;
    END;
    
    -- Sobre escritura
    OVERRIDING MEMBER FUNCTION ver_precio
    RETURN NUMBER
    AS
    BEGIN
        RETURN precio + 10;
    END;
END;
/


/*
    UTILIZACI�N
*/
SET SERVEROUTPUT ON
DECLARE
    comestible comestibles := comestibles(100,'Churritos', 20,sysdate());
BEGIN

    dbms_output.put_line(comestible.ver_precio);

END;
/

DROP TYPE COMESTIBLES;