-- ## JARDINERIA ##
-- Listado Oficinas
select * from oficina;
-- 1. Oficina y Ciudad.
select codigo_oficina, ciudad FROM oficina;
-- 2. Ciudad y Telefono de España.
select ciudad, pais, telefono from oficina where pais ="España";
-- Listado Empleados.
select * from empleado;
-- 3. Nombre, Apellido, Email Empleados con Jefe =7.
select nombre,apellido1,apellido2,email,codigo_jefe from empleado where codigo_jefe = 7 order by apellido1;
-- 4. Puesto, Nombre, Apellido , Email Jefe Empresa.
select puesto,nombre,apellido1,apellido2,email from empleado where codigo_jefe is null;
-- 5. Nombre, Apellido , Puesto empleados no sean Representante Ventas.
select nombre,apellido1,apellido2,puesto from empleado where puesto <> "Representante Ventas" order by puesto;
-- Listado Clientes.
select * from cliente;
-- 6. Listado Clientes Españoles.
select nombre_cliente as Nombre_Cliente , pais as Pais from cliente where pais = "Spain" order by nombre_cliente;
-- Listado Pedidos.
select * from pedido;
-- 7. Listado Estado de Pedidos.
select estado as Estado_Pedidos from pedido group by estado order by estado;
-- Listado Pagos.
select * from pago;
-- 8. Listado Codigos Clientes que realizaron algún pago en 2008.
-- Utilizando la función YEAR
select distinct codigo_cliente from pago where year(fecha_pago)= 2008;
-- Utilizando la función DATE_FORMAT
select distinct codigo_cliente from pago where date_format(fecha_pago, "%Y")= "2008";
-- Sin Funcion
select distinct codigo_cliente from pago where fecha_pago >= '2008-01-01' AND fecha_pago < '2009-01-01';
-- LIstado Pedidos
select * from pedido;
-- 9. Listado código pedido,código cliente, fecha esperada y fecha entrega
--   pedidos que no han sido entregados a tiempo.
select codigo_pedido as Pedido ,codigo_cliente as Cliente,fecha_esperada,fecha_entrega, (fecha_entrega-fecha_esperada) as Diferencia from pedido
where fecha_entrega > fecha_esperada ;
-- 10. Listado código pedido,código cliente,fecha esperada y fecha entrega
--    pedidos que no han sido entregados a tiempo.
-- Utilizando la función ADDDATE
select codigo_pedido as Pedido ,codigo_cliente as Cliente,fecha_esperada,fecha_entrega, (fecha_entrega-fecha_esperada) as Diferencia from pedido
where adddate(fecha_entrega, interval 2 day) <= fecha_esperada ;
-- Utilizando la función DATEDIFF
select codigo_pedido as Pedido ,codigo_cliente as Cliente,fecha_esperada,fecha_entrega, (fecha_entrega-fecha_esperada) as Diferencia from pedido
where datediff(fecha_entrega, fecha_esperada) <= -2 ;
-- 11. Listado pedidos rechazados en 2009.
select * from pedido where estado ="Rechazado" and year(fecha_pedido)=2009;
-- 12. Listado pedidos que han sido entregados en el mes de enero de cualquier año.
select * from pedido where estado ="Entregado" and month(fecha_pedido)=1;
-- Listado Pagos.
select * from pago;
-- 13. Listado pagos del 2008 mediante Paypal ordenado mayor a menor.
select * from pago where forma_pago="Paypal" and year(fecha_pago)= 2008 
order by total desc ;
-- 14. Listado formas de pago no repetidas.
select distinct forma_pago from pago order by forma_pago;
-- Litado Productos.
select * from producto;
-- 15. Listado productos gama Ornamentales con más de 100 unidades stock. 
-- Ordenado por precio de venta descendente.
select * from producto where gama="Ornamentales" and cantidad_en_stock>100 
order by precio_venta desc;
-- Listado Clientes.
select * from cliente;
-- 16. Listado clientes de ciudad Madrid y representante de ventas tenga 
-- código de empleado 11 o 30.
select * from cliente where ciudad ="Madrid" and codigo_empleado_rep_ventas in (11,30)
order by nombre_cliente;

-- Consultas multitabla (Composición interna) con INNER JOIN
-- 1. listado nombre cliente y nombre y apellido de representante de ventas.
select nombre_cliente as Cliente,empleado.nombre as NombreVendedor, empleado.apellido1 
as Apellido,empleado.apellido2 as "" from cliente inner join empleado on
cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado order by nombre_cliente;
-- 2. Nombre clientes con pagos y nombre representante ventas.
select nombre_cliente as Cliente, pago.fecha_pago as Pago,empleado.nombre as Vendedor from cliente 
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado 
inner join pago on pago.codigo_cliente=cliente.codigo_cliente 
order by cliente.nombre_cliente;
-- 3. Nombre clientes sin pagos y nombre representante ventas.
select nombre_cliente as Cliente, pago.fecha_pago as Pago,empleado.nombre as Vendedor from cliente 
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado 
left join pago on pago.codigo_cliente=cliente.codigo_cliente where pago.fecha_pago is null 
order by cliente.nombre_cliente;
-- 4. Nombre clientes con pagos y nombre representante y ciudad oficina representante.
select nombre_cliente as Cliente, pago.fecha_pago as Pago, empleado.nombre as Vendedor, oficina.ciudad as Ciudad from cliente 
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado 
inner join pago on pago.codigo_cliente=cliente.codigo_cliente 
inner join oficina on empleado.codigo_oficina=oficina.codigo_oficina 
order by cliente.nombre_cliente;
-- 5. Nombre clientes sin pagos y nombre representante y ciudad oficina representante.
select nombre_cliente as Cliente, pago.fecha_pago as Pago, empleado.nombre as Vendedor, oficina.ciudad as Ciudad from cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado 
inner join oficina on empleado.codigo_oficina=oficina.codigo_oficina 
left join pago on pago.codigo_cliente=cliente.codigo_cliente where pago.fecha_pago is null 
order by cliente.nombre_cliente;
-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
select  cliente.ciudad, cliente.codigo_cliente, cliente.nombre_cliente,oficina.linea_direccion1 as Direccion,oficina.linea_direccion2 as "" from oficina 
inner join empleado on empleado.codigo_oficina=oficina.codigo_oficina
inner join cliente on cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado
where cliente.ciudad ="Fuenlabrada";
-- 7. Nombre clientes , representante y ciudad oficina del representante.
select cliente.nombre_cliente as Cliente,empleado.nombre as Vendedor ,empleado.codigo_oficina as Oficina,oficina.ciudad as Ciudad from cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado 
inner join oficina on empleado.codigo_oficina=oficina.codigo_oficina order by cliente;
-- 8. Nombre empleados y nombre de sus jefes.
select E1.nombre as Empleado, E2.nombre as Jefe from empleado as E2
right join empleado as E1 on E1.codigo_jefe = E2.codigo_empleado;
-- 9. Nombre clientes no se les entrego a tiempo pedido.
select cliente.codigo_cliente as Cliente, cliente.nombre_cliente as Nombre, pedido.fecha_esperada as Prometido,
pedido.fecha_entrega as Entregado, (fecha_entrega-fecha_esperada) as Diferencia from cliente
inner join pedido on pedido.codigo_cliente=cliente.codigo_cliente 
where pedido.fecha_entrega>pedido.fecha_esperada order by cliente.nombre_cliente;
-- 10. Diferentes gamas de producto que ha comprado cada cliente.
select cliente.codigo_cliente as Cliente, cliente.nombre_cliente as Nombre, producto.gama as Gama from cliente
inner join pedido on pedido.codigo_cliente=cliente.codigo_cliente
inner join detalle_pedido on pedido.codigo_pedido=detalle_pedido.codigo_pedido
inner join producto on detalle_pedido.codigo_producto=producto.codigo_producto
group by cliente,gama;

-- Consultas multitabla (Composición externa) Usando LEFT JOIN, RIGHT JOIN, JOIN.
-- 1. Clientes que no han realizado ningún pago.
select cliente.nombre_cliente as Cliente, pago.fecha_pago as Pago from cliente
left join pago on cliente.codigo_cliente=pago.codigo_cliente
where pago.fecha_pago is null;
-- 2. Clientes que no han realizado ningún pedido.
select cliente.nombre_cliente as Cliente, pedido.fecha_pedido as Pedido from cliente
left join pedido on cliente.codigo_cliente=pedido.codigo_cliente
where pedido.fecha_pedido is null;
-- 3. Clientes que no han realizado ningún pago y ningún pedido.
select cliente.nombre_cliente as Cliente, pedido.fecha_pedido as Pedido,pago.fecha_pago as Pago from cliente
left join pedido on cliente.codigo_cliente=pedido.codigo_cliente
left join pago on cliente.codigo_cliente=pago.codigo_cliente
where pedido.fecha_pedido is null and pedido.fecha_pedido is null ;
-- 4. Empleados que no tienen una oficina asociada.
select empleado.nombre as Empleado, empleado.codigo_oficina from empleado
left join oficina on empleado.codigo_oficina=oficina.codigo_oficina
where oficina.codigo_oficina is null;
-- 5. Empleados que no tienen un cliente asociado.
select empleado.nombre as Empleado, cliente.nombre_cliente as Cliente from empleado
left join cliente on cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado
where cliente.codigo_empleado_rep_ventas is null order by empleado.nombre;
-- 6. Empleados no tienen una oficina asociada y no tienen un cliente asociado.
select empleado.nombre as Empleado, cliente.nombre_cliente as Cliente, empleado.codigo_oficina from empleado
left join oficina on empleado.codigo_oficina=oficina.codigo_oficina
left join cliente on cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado
where oficina.codigo_oficina is null and cliente.codigo_empleado_rep_ventas is null order by empleado.nombre;
-- 7. Productos que nunca han aparecido en un pedido.
select producto.nombre as Producto, detalle_pedido.codigo_pedido as Pedido from producto
left join detalle_pedido on producto.codigo_producto=detalle_pedido.codigo_producto
where detalle_pedido.codigo_pedido is null group by nombre,pedido 
order by producto.nombre ;
-- 8. Oficinas sin ningun empleado que hayan sido representante ventas 
-- de un cliente que haya realizado la compra de algún producto de la gama Frutales.
-- REVISAR

-- 9. Clientes que han realizado algún pedido, pero no han realizado ningún pago.
select cliente.nombre_cliente as Cliente,pedido.fecha_pedido as Pedido, pago.fecha_pago as Pago from cliente
left join pedido on cliente.codigo_cliente=pedido.codigo_cliente
left join pago on cliente.codigo_cliente=pago.codigo_cliente
where pedido.fecha_pedido is not null and pago.fecha_pago is null;
-- 10. Empleados que no tienen clientes asociados y el nombre de su jefe asociado.
select E1.nombre as Empleado, cliente.nombre_cliente as Cliente, E2.nombre as E2 from empleado
left join cliente on cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado
right join empleado as E1 on E1.codigo_jefe = E2.codigo_empleado
where cliente.codigo_empleado_rep_ventas is null and empleado.codigo_jefe is not null order by empleado.nombre;
-- REVISAR

-- Consultas resumen
-- 1. Cuántos empleados hay en la compañía.
select count(*) from empleado;
-- Total Clientes.
select count(*) from cliente;
-- 2. Cuántos clientes tiene cada país.
select pais as Pais, count(*) as CantidadClientes from cliente
group by pais order by pais;
-- 3. Cuál fue el pago medio en 2009.
select round(avg(total)) as PagoMedio from pago where year(fecha_pago)=2009;
-- 4. Cuántos pedidos hay en cada estado? 
-- Ordenado descendente por el número de pedidos.
select estado as EstadoPedido, count(*) as CantidadPedidos from pedido
group by estado order by CantidadPedidos desc;
-- 5. Precio de venta del producto más caro y más barato.
select 'Mas caro' as Producto, max(precio_venta) as Precio from producto
UNION 
select 'Mas barato' as Producto,min(precio_venta) as Precio from producto;
-- 6. Calcula el número de clientes que tiene la empresa.
select count(*) from cliente;
-- 7. Cuántos clientes tiene la ciudad de Madrid.
select count(*) from cliente where ciudad = "Madrid";
-- 8. Cuántos clientes tiene las ciudades que empiezan por M?
select count(*) from cliente where ciudad like"M%";
-- 9. Nombre representantes de ventas y número clientes que atiende cada uno.
select empleado.nombre as Empleado, count(cliente.nombre_cliente) as CantidadClientes from empleado
inner join cliente on cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado
where puesto="Representante Ventas" group by empleado.nombre order by empleado.nombre;
-- 10. Número clientes que no tiene asignado representante de ventas.
select count(*) from cliente where codigo_empleado_rep_ventas is null;
-- 11. Fecha primer y último pago por clientes. 
-- El listado deberá mostrar el nombre y los apellidos de cada cliente.
select pago.codigo_cliente as ClienteNro, cliente.nombre_contacto as Nombre,cliente.apellido_contacto as Apellido, min(pago.fecha_pago) as PrimerPago, max(pago.fecha_pago) as UltimoPago from pago
inner join cliente on pago.codigo_cliente=cliente.codigo_cliente
group by pago.codigo_cliente;
-- 12. Número de productos diferentes que hay en cada uno de los pedidos.
select codigo_pedido as PedidoNro, count(codigo_producto) as CantidadProductos from detalle_pedido
group by codigo_pedido;
-- 13. Suma cantidad total productos en cada uno de los pedidos.
select codigo_pedido as PedidoNro, sum(cantidad) as CantidadVendida from detalle_pedido
group by codigo_pedido;
-- 14. Los 20 productos más vendidos y total de unidades vendidas 
-- ordenado por número total de unidades vendidas.
select codigo_producto as Producto, count(codigo_producto) as CantidadProductos, sum(cantidad) as CantidadVendida from detalle_pedido
group by codigo_producto order by CantidadVendida desc limit 20;
-- 15. Facturación empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. 
-- La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. 
-- El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
select round(sum(cantidad*precio_unidad)) as Facturacion, 
round((sum(cantidad*precio_unidad)*0.21)) as IVA,
round((sum(cantidad*precio_unidad)*1.21)) as TotalFacturado
from detalle_pedido ;
-- 16. La misma información pregunta anterior agrupada por código de producto.
select codigo_producto as Producto, round(sum(cantidad*precio_unidad)) as Facturacion, 
round((sum(cantidad*precio_unidad)*0.21)) as IVA,
round((sum(cantidad*precio_unidad)*1.21)) as TotalFacturado
from detalle_pedido group by codigo_producto order by codigo_producto;




