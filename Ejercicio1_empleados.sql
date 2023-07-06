select * from empleados;
SELECT nombre,sal_emp FROM personal.empleados;
select nombre,comision_emp from empleados;
select nombre, cargo_emp from empleados where cargo_emp = "Secretaria";
select nombre, cargo_emp from empleados where cargo_emp = "Vendedor" order by nombre;
select nombre, cargo_emp,sal_emp from empleados order by sal_emp;
select nombre as Nombre,cargo_emp as Cargo from empleados;
select nombre,id_depto,sal_emp,comision_emp from empleados where id_depto = 2000 order by comision_emp;
select nombre,id_depto,(sal_emp+comision_emp+500) as Salario_Total from empleados where id_depto = 3000 order by nombre;
select nombre from empleados where nombre like "J%" order by nombre;
select nombre,sal_emp,comision_emp,(sal_emp+comision_emp) as Salario_Total from empleados where comision_emp > 1000 order by comision_emp; 
select nombre,sal_emp,comision_emp,(sal_emp+comision_emp) as Salario_Total from empleados where comision_emp = 0 order by comision_emp; 
select nombre,comision_emp as Comision,sal_emp as Salario, (comision_emp-sal_emp) as Diferencia from empleados where comision_emp > sal_emp order by nombre; 
select nombre,comision_emp as Comision,sal_emp as Salario from empleados where comision_emp <= (sal_emp *0.3) order by nombre; 
select nombre from empleados where nombre like "%MA%" order by nombre;
select nombre from empleados where nombre not like "%MA%" order by nombre;
select Max(sal_emp) from empleados ;
select nombre from empleados order by nombre desc limit 1;
select Max(sal_emp) as SalarioMax, MIN(sal_emp) as SalarioMin, (Max(sal_emp)-Min(sal_emp)) as Diferencia from empleados;
select id_depto, round(AVG(sal_emp)) as SalarioProm from empleados group by id_depto;
select id_depto,nombre, sal_emp from empleados where sal_emp >= (select round(avg(sal_emp)) from empleados) order by id_depto;


