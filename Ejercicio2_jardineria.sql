-- Active: 1688148886797@@Localhost@3306@jardineria
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
-- Listado Pedidos
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
select c.nombre_cliente as Cliente, e.nombre as NombreVendedor, e.apellido1 
as Apellido, e.apellido2 as "" from cliente c 
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado order by nombre_cliente;
-- 2. Nombre clientes con pagos y nombre representante ventas.
select c.nombre_cliente as Cliente, p.fecha_pago as Pago,e.nombre as Vendedor from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado 
inner join pago p on p.codigo_cliente=c.codigo_cliente 
order by c.nombre_cliente;
-- 3. Nombre clientes sin pagos y nombre representante ventas.
select c.nombre_cliente as Cliente, p.fecha_pago as Pago,e.nombre as Vendedor from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado 
left join pago p on p.codigo_cliente=c.codigo_cliente where p.fecha_pago is null 
order by c.nombre_cliente;
-- 4. Nombre clientes con pagos y nombre representante y ciudad oficina representante.
select c.nombre_cliente as Cliente, p.fecha_pago as Pago, e.nombre as Vendedor, o.ciudad as Ciudad 
from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado 
inner join pago p on p.codigo_cliente=c.codigo_cliente 
inner join oficina o on e.codigo_oficina=o.codigo_oficina 
order by c.nombre_cliente;
-- 5. Nombre clientes sin pagos y nombre representante y ciudad oficina representante.
select c.nombre_cliente as Cliente, p.fecha_pago as Pago, e.nombre as Vendedor, o.ciudad as Ciudad from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado 
inner join oficina o on e.codigo_oficina=o.codigo_oficina 
left join pago p on p.codigo_cliente=c.codigo_cliente where p.fecha_pago is null 
order by c.nombre_cliente;
-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
select  c.ciudad, c.codigo_cliente, c.nombre_cliente,o.linea_direccion1 as Direccion,o.linea_direccion2 as "" from oficina o
inner join empleado e on e.codigo_oficina=o.codigo_oficina
inner join cliente c on c.codigo_empleado_rep_ventas=e.codigo_empleado
where c.ciudad ="Fuenlabrada";
-- 7. Nombre clientes , representante y ciudad oficina del representante.
select c.nombre_cliente as Cliente,e.nombre as Vendedor ,e.codigo_oficina as Oficina,o.ciudad as Ciudad from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado 
inner join oficina o on e.codigo_oficina=o.codigo_oficina order by cliente;
-- 8. Nombre empleados y nombre de sus jefes.
select E1.nombre as Empleado, E2.nombre as Jefe from empleado as E2
right join empleado as E1 on E1.codigo_jefe = E2.codigo_empleado;
-- 9. Nombre clientes no se les entrego a tiempo pedido.
select c.codigo_cliente as Cliente, c.nombre_cliente as Nombre, p.fecha_esperada as Prometido,
p.fecha_entrega as Entregado, datediff(p.fecha_entrega,p.fecha_esperada) as Diferencia from cliente c
inner join pedido p on p.codigo_cliente=c.codigo_cliente 
where datediff(p.fecha_entrega,p.fecha_esperada)>0 
order by c.nombre_cliente;
-- 10. Diferentes gamas de producto que ha comprado cada cliente.
select c.codigo_cliente as NroCliente, c.nombre_cliente as NombreCliente, pr.gama as Gama from cliente c
inner join pedido p on p.codigo_cliente=c.codigo_cliente
inner join detalle_pedido dp on p.codigo_pedido=dp.codigo_pedido
inner join producto pr on dp.codigo_producto=pr.codigo_producto
group by c.codigo_cliente, pr.gama;

-- Consultas multitabla (Composición externa) Usando LEFT JOIN, RIGHT JOIN, JOIN.
-- 1. Clientes que no han realizado ningún pago.
select c.nombre_cliente as Cliente, p.fecha_pago as Pago from cliente c
left join pago p on c.codigo_cliente=p.codigo_cliente
where p.fecha_pago is null;
-- 2. Clientes que no han realizado ningún pedido.
select c.nombre_cliente as Cliente, p.fecha_pedido as Pedido from cliente c
left join pedido p on c.codigo_cliente=p.codigo_cliente
where p.fecha_pedido is null;
-- 3. Clientes que no han realizado ningún pago y ningún pedido.
select c.nombre_cliente as Cliente, p.fecha_pedido as Pedido,pa.fecha_pago as Pago from cliente c
left join pedido p on c.codigo_cliente=p.codigo_cliente
left join pago pa on c.codigo_cliente=pa.codigo_cliente
where p.fecha_pedido is null and pa.fecha_pago is null ;
-- 4. Empleados que no tienen una oficina asociada.
select e.nombre as Empleado, e.codigo_oficina from empleado e
left join oficina o on e.codigo_oficina=o.codigo_oficina
where o.codigo_oficina is null;
-- 5. Empleados que no tienen un cliente asociado.
select e.nombre as Empleado, c.nombre_cliente as Cliente from empleado e
left join cliente c on c.codigo_empleado_rep_ventas=e.codigo_empleado
where c.codigo_empleado_rep_ventas is null 
order by e.nombre;
-- 6. Empleados no tienen una oficina asociada y no tienen un cliente asociado.
select e.nombre as Empleado, c.nombre_cliente as Cliente, e.codigo_oficina from empleado e
left join oficina o on e.codigo_oficina=o.codigo_oficina
left join cliente c on c.codigo_empleado_rep_ventas=e.codigo_empleado
where o.codigo_oficina is null and c.codigo_empleado_rep_ventas is null 
order by e.nombre;
-- REVISAR
-- 7. Productos que nunca han aparecido en un pedido.
select pr.nombre as Producto, dp.codigo_pedido as Pedido from producto pr
left join detalle_pedido dp on pr.codigo_producto=dp.codigo_producto
where dp.codigo_pedido is null 
group by nombre, pedido 
order by pr.nombre ;
-- 8. Oficinas sin ningun empleado que hayan sido representante ventas 
-- de un cliente que haya realizado la compra de algún producto de la gama Frutales.
select c.nombre_cliente as Nombre,p.codigo_cliente as Pedido,pr.gama as Gama from cliente c
left join pedido p on c.codigo_cliente=p.codigo_cliente
left join detalle_pedido dp on dp.codigo_pedido=p.codigo_pedido
left join producto pr on dp.codigo_producto=pr.codigo_producto
left join empleado e on c.codigo_empleado_rep_ventas=e.codigo_empleado
where e.puesto<>"Representante Ventas" and pr.gama="Frutales"
group by c.nombre_cliente,p.codigo_cliente,pr.gama;
-- 9. Clientes que han realizado algún pedido, pero no han realizado ningún pago.
select c.nombre_cliente as Cliente,p.fecha_pedido as Pedido, pa.fecha_pago as Pago from cliente c
left join pedido p on c.codigo_cliente=p.codigo_cliente
left join pago pa on c.codigo_cliente=pa.codigo_cliente
where p.fecha_pedido is not null and pa.fecha_pago is null;
-- 10. Empleados que no tienen clientes asociados y el nombre de su jefe asociado.
select distinct e2.nombre as Empelado, e1.nombre as Jefe, c.nombre_cliente  from empleado as e1
inner join empleado as e2 on e1.codigo_empleado = e2.codigo_jefe
left join cliente c on c.codigo_empleado_rep_ventas = e1.codigo_empleado
where c.nombre_cliente is null group by 1,2,3 
order by e1.nombre,e2.nombre; 

-- Consultas resumen
-- 1. Cuántos empleados hay en la compañía.
select count(*)  as Total from empleado;
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
select e.nombre as Empleado, count(c.nombre_cliente) as CantidadClientes from empleado e
inner join cliente c on c.codigo_empleado_rep_ventas=e.codigo_empleado
where puesto="Representante Ventas" 
group by e.nombre 
order by e.nombre;
-- 10. Número clientes que no tiene asignado representante de ventas.
select e.nombre as Empleado, count(c.nombre_cliente) as CantidadClientes from empleado e
inner join cliente c on c.codigo_empleado_rep_ventas=e.codigo_empleado
where puesto<>"Representante Ventas" 
group by e.nombre 
order by e.nombre;
-- 11. Fecha primer y último pago por clientes. 
-- El listado deberá mostrar el nombre y los apellidos de cada cliente.
select pa.codigo_cliente as ClienteNro, c.nombre_contacto as Nombre,c.apellido_contacto as Apellido, min(pa.fecha_pago) as PrimerPago, max(pa.fecha_pago) as UltimoPago from pago pa
inner join cliente c on pa.codigo_cliente=c.codigo_cliente
group by pa.codigo_cliente 
order by c.nombre_contacto;
-- 12. Número de productos diferentes que hay en cada uno de los pedidos.
select codigo_pedido as PedidoNro, count(codigo_producto) as CantidadProductos from detalle_pedido
group by codigo_pedido;
-- 13. Suma cantidad total productos en cada uno de los pedidos.
select codigo_pedido as PedidoNro, sum(cantidad) as CantidadVendida from detalle_pedido
group by codigo_pedido;
-- 14. Los 20 productos más vendidos y total de unidades vendidas 
-- ordenado por número total de unidades vendidas.
select dp.codigo_producto as CodigoProd, pr.nombre as NombreProd, count(dp.codigo_producto) as CantidadProductos, sum(dp.cantidad) as CantidadVendida from detalle_pedido dp
inner join producto pr on dp.codigo_producto=pr.codigo_producto
group by dp.codigo_producto 
order by sum(dp.cantidad) desc limit 20;
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
from detalle_pedido 
group by codigo_producto 
order by codigo_producto;
-- 17. La misma información pregunta anterior agrupada por código de producto 
-- filtrada por los códigos que empiecen por OR.
select codigo_producto as Producto, round(sum(cantidad*precio_unidad)) as Facturacion, 
round((sum(cantidad*precio_unidad)*0.21)) as IVA,
round((sum(cantidad*precio_unidad)*1.21)) as TotalFacturado
from detalle_pedido where codigo_producto like "OR%" 
group by codigo_producto 
order by codigo_producto;
-- 18. Ventas totales productos facturados más de 3000 euros. 
-- 	Nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA)
select dp.codigo_producto as Codigo, p.nombre as Nombre, round(sum(dp.cantidad)) as UnidadesVendidas, round(sum(dp.cantidad*dp.precio_unidad)) as Facturacion,
round((sum(dp.cantidad*dp.precio_unidad)*0.21)) as IVA,
round((sum(dp.cantidad*dp.precio_unidad)*1.21)) as TotalFacturado
from detalle_pedido dp
inner join producto p on p.codigo_producto=dp.codigo_producto
group by dp.codigo_producto 
Having round(sum(dp.cantidad*dp.precio_unidad)) > 3000
order by dp.codigo_producto;

-- Subconsultas con operadores básicos de comparación
-- 1. Nombre del cliente con mayor límite de crédito.
select nombre_cliente as Cliente, round(limite_credito) as LimiteCredito from cliente 
order by limite_credito desc limit 1;
-- 2. Producto que tenga el precio de venta más caro.
select nombre as Producto, round(precio_venta) as Precio from producto
order by precio_venta desc limit 1;
-- 3. Nombre del producto con mas ventas. Calcular número total unidades vendidas. 
select pr.codigo_producto as Producto, pr.nombre as NombreProducto, round(sum(dp.cantidad)) as UnidadesVendidas from detalle_pedido dp
inner join producto pr on dp.codigo_producto=pr.codigo_producto
group by dp.codigo_producto 
order by round(sum(dp.cantidad)) desc limit 1;
-- 4. Clientes cuyo límite de crédito sea mayor que los pagos que haya realizado.(Sin utilizar INNER JOIN).
select c.nombre_cliente as Cliente, round(c.limite_credito) as LimiteCredito,
round((select sum(total) from pago p where p.codigo_cliente = c.codigo_cliente)) as TotalPagos,
round(c.limite_credito - (select sum(total) from pago p where p.codigo_cliente=c.codigo_cliente)) as Diferencia
from cliente c where round(c.limite_credito)>round((select sum(total) from pago p 
where p.codigo_cliente = c.codigo_cliente))
order by c.nombre_cliente;
-- 5. Producto que más unidades tiene en stock.
select nombre as Nombre, cantidad_en_stock as Stock, (max(cantidad_en_stock)) as StockMayor from producto
group by nombre, cantidad_en_stock
having cantidad_en_stock= (select max(cantidad_en_stock) from producto);
-- 6. Producto que menos unidades tiene en stock.
select nombre as Nombre, cantidad_en_stock as Stock, (min(cantidad_en_stock)) as StockMinimo from producto
group by nombre, cantidad_en_stock
having cantidad_en_stock= (select min(cantidad_en_stock) from producto);
-- 7. Nombre, apellidos y email empleados que están a cargo de Alberto Soria.
select E1.nombre as Empleado, E1.apellido1 as Apellido, E1.apellido2 as "", E1.email as Email, 
E2.nombre as NombreJefe, E2.apellido1 as ApellidoJefe from empleado as E2
right join empleado as E1 on E1.codigo_jefe = E2.codigo_empleado
where E2.nombre="Alberto" and E2.apellido1="Soria";
-- 7.1 Usando Concatenar
select (concat(E1.nombre,"  ",E1.apellido1,"  ",E1.apellido2)) as Empleado, E1.email as Email,
(concat(E2.nombre,"  ",E2.apellido1,"  ",E2.apellido2)) as Jefe 
from empleado E2 
right join empleado as E1 on E1.codigo_jefe = E2.codigo_empleado
where E2.nombre="Alberto" and E2.apellido1="Soria"
order by e2.nombre;

-- Subconsultas con ALL y ANY
-- 1. Nombre del cliente con mayor límite de crédito.
-- ALL
select nombre_cliente as Cliente, round(limite_credito) as LimiteCredito from cliente 
where limite_credito = all (select max(limite_credito) from cliente);
-- ANY
select nombre_cliente as Cliente, round(limite_credito) as LimiteCredito from cliente 
where limite_credito = any (select max(limite_credito) from cliente);
-- 2. Producto que tenga el precio de venta más caro.
-- ALL
select nombre as Producto, round(precio_venta) as Precio from producto
where precio_venta = all (select max(precio_venta) from producto);
-- ANY
select nombre as Producto, round(precio_venta) as Precio from producto
where precio_venta = any (select max(precio_venta) from producto);
-- 3. Producto que menos unidades tiene en stock.
-- ALL
select nombre as Nombre, cantidad_en_stock as Stock from producto
where cantidad_en_stock = all (select min(cantidad_en_stock) from producto);
-- ANY
select nombre as Nombre, cantidad_en_stock as Stock from producto
where cantidad_en_stock = any (select min(cantidad_en_stock) from producto);

-- Subconsultas con IN y NOT IN
-- 1. Nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
select nombre as Nombre, apellido1 as Apellido , puesto as Cargo from empleado
where codigo_empleado not in (select codigo_empleado_rep_ventas from cliente);
-- 2. Clientes que no han realizado ningún pago.
select codigo_cliente as NroCliente, nombre_cliente as Nombre from cliente
where codigo_cliente not in (select codigo_cliente from pago) 
order by nombre_cliente;
-- 3. Clientes que sí han realizado ningún pago.
select codigo_cliente as NroCliente, nombre_cliente as Nombre from cliente
where codigo_cliente in (select codigo_cliente from pago) 
order by nombre_cliente;
-- 4. Productos que nunca han aparecido en un pedido.
select codigo_producto as ProductoNro, nombre as Producto from producto
where codigo_producto not in (select codigo_producto from detalle_pedido) 
order by codigo_producto;
-- 5. Nombre,apellidos,puesto y teléfono oficina empleados que no sean representante de ventas ningun cliente.
select nombre as Nombre, apellido1 as Apellido , puesto as Cargo, extension as TelInterno from empleado
where codigo_empleado not in (select codigo_empleado_rep_ventas from cliente) 
and codigo_oficina in (select codigo_oficina from oficina)
and puesto<>"Representante Ventas" 
order by puesto;

-- Subconsultas con EXISTS y NOT EXISTS
-- 1. Listado Clientes que no han realizado ningún pago.
select codigo_cliente as NroCliente, nombre_cliente as Nombre from cliente
where not exists(select * from pago 
where cliente.codigo_cliente=pago.codigo_cliente) 
order by nombre_cliente;
-- 2. Listado que muestre solamente los clientes que sí han realizado ningún pago.
select codigo_cliente as NroCliente, nombre_cliente as Nombre from cliente
where exists(select * from pago where cliente.codigo_cliente=pago.codigo_cliente) 
order by nombre_cliente;
-- 3. Listado de los productos que nunca han aparecido en un pedido.
select codigo_producto as ProductoNro, nombre as Producto from producto
where  not exists (select * from detalle_pedido where producto.codigo_producto=detalle_pedido.codigo_producto) 
order by codigo_producto;
-- 4. Listado de los productos que han aparecido en un pedido alguna vez.
select codigo_producto as ProductoNro, nombre as Producto from producto
where  exists (select * from detalle_pedido where producto.codigo_producto=detalle_pedido.codigo_producto) 
order by codigo_producto;





