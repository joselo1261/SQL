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


