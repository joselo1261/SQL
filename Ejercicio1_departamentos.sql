select * from departamentos;
SELECT nombre_depto FROM departamentos;
select nombre_jefe_depto as Jefe, ciudad from departamentos where ciudad = "Ciudad Real" ;
select nombre_depto as Departamento from departamentos where nombre_depto in ("Ventas","Investigacion","Produccion") order by nombre_depto;
select nombre_depto as Departamento from departamentos where nombre_depto not in ("Ventas","Investigacion","Produccion") order by nombre_depto;
select nombre_depto as Departamento , count(id_depto) as CantidadEmp  from departamentos  group by nombre_depto having count(id_depto)>3;
select nombre_depto as Departamento , count(id_depto) as CantidadEmp  from departamentos  group by nombre_depto having count(id_depto)=0;