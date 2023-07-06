select * from oficina;
SELECT codigo_oficina, ciudad FROM oficina;
select ciudad, pais, telefono from oficina where pais ="España";
select * from empleado;
select nombre,apellido1,apellido2,email,codigo_jefe from empleado where codigo_jefe = 7 order by apellido1;
select puesto,nombre,apellido1,apellido2,email from empleado where codigo_jefe is null;
select nombre,apellido1,apellido2,puesto from empleado where puesto <> "Representante Ventas" order by puesto;
select * from cliente;
select nombre_cliente as Nombre_Cliente , pais as Pais from cliente where pais = "Spain" order by nombre_cliente;
select * from pedido;
select estado as Estado_Pedidos from pedido group by estado order by estado;
select * from pago;
select DISTINCT codigo_cliente from pago where year(fecha_pago)= 2008;
select DISTINCT codigo_cliente from pago where date_format(fecha_pago, "%Y")= "2008";
select DISTINCT codigo_cliente from pago where fecha_pago >= '2008-01-01' AND fecha_pago < '2009-01-01';


