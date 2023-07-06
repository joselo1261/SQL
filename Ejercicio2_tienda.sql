--  ## TIENDA ##
-- 1. Lista completa productos.
select * from producto;
-- 2.3. Codigo, Nombres y Precios de productos.
select codigo, nombre, precio from producto;
-- 4. Precios Redondeados.
select codigo, nombre, round(precio) as Precio from producto;
-- 5. Codigo Fabricantes.
select codigo_fabricante from producto where nombre is not null order by codigo_fabricante;
-- 6.7. Codigo Fabricantes sin repetidos, ordenados.
select distinct codigo_fabricante from producto where nombre is not null order by codigo_fabricante;
-- 8. Productos ordenados asc. y Precios desc.
select nombre, precio from producto order by nombre, precio desc;
-- Lista completa fabricantes.
select * from fabricante;
-- 9. Primeros 5 registros Fabricante.
select * from fabricante limit 5;
-- 10. Nombre y Precio producto mas barato.
select codigo, nombre, precio from producto order by precio limit 1;
-- 11. Nombre y Precio producto mas caro.
select codigo, nombre, precio from producto order by precio desc limit 1;
-- 12. Productos precio <= 120.
select codigo, nombre, precio from producto where precio <= 120 order by precio;
-- 13. Productos precio entre 60 y 200.
select codigo, nombre, precio from producto where precio between 60 and 200 order by precio;
-- 14. Productos Fabricante 1,3,5.
select codigo, nombre, codigo_fabricante from producto where codigo_fabricante in (1,3,5);
-- 15. Productos que sean Portatil.
select codigo, nombre from producto where nombre like "%Portatil%";

-- ## CONSULTAS MULTITABLA ##
-- 1. Codigo, Nombre Producto, Fabricante y Nombre.
select producto.codigo, producto.nombre,producto.codigo_fabricante, fabricante.nombre as Fabricante from producto 
inner join fabricante on producto.codigo_fabricante=fabricante.codigo;
-- 2. Nombre Producto, Precio, Nombre Fabricante ordenado.
select producto.nombre, producto.precio, fabricante.nombre as Fabricante from producto 
inner join fabricante on producto.codigo_fabricante=fabricante.codigo order by fabricante.nombre ;
-- 3. Nombre Producto, Precio, Nombre Fabricante mas barato.
select producto.nombre, producto.precio, fabricante.nombre  as Fabricante from producto 
inner join fabricante on producto.codigo_fabricante=fabricante.codigo order by producto.precio limit 1;
-- 4. Productos Lenovo.
select producto.nombre,fabricante.nombre  as Fabricante from producto 
inner join fabricante on producto.codigo_fabricante=fabricante.codigo where fabricante.nombre ="Lenovo";
-- 5. Productos Fabricante Crucial Precio > 200.
select producto.nombre,producto.precio,fabricante.nombre  as Fabricante from producto 
inner join fabricante on producto.codigo_fabricante=fabricante.codigo 
where fabricante.nombre ="Crucial" and producto.precio > 200;
-- 6. Productos Asus y Hewlett-Packard.
select producto.nombre, fabricante.nombre  as Fabricante from producto 
inner join fabricante on producto.codigo_fabricante=fabricante.codigo 
where fabricante.nombre in ("Asus","Hewlett-Packard");
-- 7. Nombre Producto, Precio, Nombre Fabricante Precio >=180 
-- Ordenado Precio desc y Nombre asc.
select producto.nombre,round(producto.precio) as Precio,fabricante.nombre as Fabricante from producto 
inner join fabricante on producto.codigo_fabricante=fabricante.codigo 
where producto.precio >= 180 order by producto.precio desc,producto.nombre;

-- ## CONSULTAS MULTITABLA ##
-- Usando LEFT JOIN y RIGHT JOIN.
-- 1. Listado Fabricantes con o sin productos.
select fabricante.codigo,fabricante.nombre as Fabricante ,producto.nombre as Producto from fabricante
left join producto on fabricante.codigo=producto.codigo_fabricante;
-- 2. Fabricantes sin producto
select fabricante.codigo,fabricante.nombre as Fabricante, producto.nombre as Producto from fabricante
left join producto on fabricante.codigo=producto.codigo_fabricante where producto.nombre is null ;

-- Subconsultas (En la cláusula WHERE) 
-- 1. Productos Fabricante Lenovo
select * from producto where codigo_fabricante = (select codigo from fabricante where nombre = "Lenovo");
-- 2. Productos mismo precio al Producto mas caro de Fabricante Lenovo.
select * from producto where precio =
(select max(precio) from producto where codigo_fabricante = 
(select codigo from fabricante where nombre = "Lenovo"));
-- 3. Producto mas caro de Lenovo.
select nombre, round(precio) as Precio from producto where precio =
(select max(precio) from producto where codigo_fabricante = 
(select codigo from fabricante where nombre = "Lenovo"));
-- 4. Productos Asus Precio mayor al Precio Medio general.
select nombre, round(precio) as Precio from producto where precio >
(select round(AVG(precio)) from producto where codigo_fabricante = 
(select codigo from fabricante where nombre = "Asus")) and 
codigo_fabricante = 
(select codigo from fabricante where nombre = "Asus");
-- 5. Precio medio Asus.
select round(AVG(precio)) as PrecioMedio from producto where codigo_fabricante = 
(select codigo from fabricante where nombre = "Asus");

-- Subconsultas con IN y NOT IN
-- 1. Fabricantes que tienen productos asociados.
select nombre from fabricante where codigo in (select distinct codigo_fabricante from producto);
-- 2. Fabricantes que no tiene productos asociados.
select nombre from fabricante where codigo not in (select distinct codigo_fabricante from producto);

-- Subconsultas (En la cláusula HAVING)
-- 1. Fabricantes mismo nro productos que Lenovo
select fabricante.nombre from fabricante, producto where fabricante.nombre<>"Lenovo" 
and fabricante.codigo=producto.codigo_fabricante
group by fabricante.nombre Having count(producto.codigo_fabricante) = 
(select count(*) from producto where codigo_fabricante = 
(select codigo from fabricante where nombre = "Lenovo"));
-- Conteo productos Lenovo
select count(*) as Cantidad from producto where codigo_fabricante = 
(select codigo from fabricante where nombre = "Lenovo");
