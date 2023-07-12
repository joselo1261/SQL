-- ## POKEMON ##
-- 1. Nombre de todos los pokemon
select nombre as Nombre from pokemon order by nombre;
-- 2. Pokemon que pesen menos de 10k.
select nombre as Nombre, peso as Peso_Kg from pokemon 
where peso < 10 order by nombre;
-- 3. Pokemon de tipo agua.
select t.nombre as Tipo , po.nombre as Nombre from pokemon po
inner join pokemon_tipo pt on po.numero_pokedex=pt.numero_pokedex
inner join tipo t on pt.id_tipo=t.id_tipo
where t.nombre="Agua" order by nombre;
-- 4. Pokemon de tipo agua, fuego o tierra ordenados por tipo.
select t.nombre as Tipo , po.nombre as Nombre from pokemon po
inner join pokemon_tipo pt on po.numero_pokedex=pt.numero_pokedex
inner join tipo t on pt.id_tipo=t.id_tipo order by tipo, nombre;
-- 5. Pokemon que son de tipo fuego y volador.
select t.nombre as Tipo , po.nombre as Nombre from pokemon po
inner join pokemon_tipo pt on po.numero_pokedex=pt.numero_pokedex
inner join tipo t on pt.id_tipo=t.id_tipo 
where t.nombre in ("Fuego","Volador") order by tipo, nombre;
-- 6. Pokemon con una estadística base de ps mayor que 200.
select po.nombre as Nombre, eb.ps from pokemon po
inner join estadisticas_base eb on po.numero_pokedex=eb.numero_pokedex
where eb.ps > 200;
-- 7. Datos(nombre, peso, altura) de la prevolución de Arbok.
select p.nombre as Nombre, p.peso as Peso, p.altura as Altura from pokemon p
inner join evoluciona_de e on p.numero_pokedex = e.pokemon_origen
inner join pokemon p1 on e.pokemon_evolucionado = p1.numero_pokedex
where p1.nombre = "Arbok";
-- 8. Pokemon que evolucionan por intercambio.
select po.nombre as Nombre, te.tipo_evolucion as Evolucion from pokemon po
inner join pokemon_forma_evolucion pfe on po.numero_pokedex=pfe.numero_pokedex
inner join forma_evolucion fe on pfe.id_forma_evolucion=fe.tipo_evolucion
inner join tipo_evolucion te on fe.tipo_evolucion=te.id_tipo_evolucion
where te.tipo_evolucion="Intercambio" order by Nombre;
-- 9. Nombre del movimiento con más prioridad.
select nombre as NombrePrioridad from movimiento order by prioridad desc limit 1;
-- 10. Pokemon más pesado.
select nombre, peso from pokemon order by peso desc limit 1;
-- 11. Nombre y tipo del ataque con más potencia.
select nombre as Nombre ,potencia as Power from movimiento order by potencia desc limit 1;
-- 12. Número de movimientos de cada tipo.
select distinct nombre as Nombre, precision_mov as Movimientos from movimiento
order by nombre;
-- 13. Movimientos que puedan envenenar.
select distinct nombre as Nombre, descripcion as Descripcion from movimiento
where descripcion like "%Envenena%" order by nombre;
-- 14. Movimientos que causan daño, ordenados alfabéticamente por nombre.
select distinct nombre as Nombre, descripcion as Descripcion from movimiento
where descripcion like "%causa daño%" order by nombre;
-- 15. Movimientos que aprende Pikachu.
select po.nombre as Nombre, mov.nombre as Movimientos from pokemon po
inner join pokemon_movimiento_forma pmf on po.numero_pokedex=pmf.numero_pokedex
inner join movimiento mov on pmf.id_movimiento=mov.id_movimiento
where po.nombre="Pikachu" group by mov.nombre order by mov.nombre;
-- 15.1 Otra opcion --
select m.nombre, p.nombre
from pokemon p, movimiento m, pokemon_movimiento_forma pfe
where p.numero_pokedex = pfe.numero_pokedex
and m.id_movimiento = pfe.id_movimiento
and p.nombre = 'Pikachu' group by m.nombre;
-- 16. Movimientos que aprende pikachu por MT (tipo de aprendizaje).
select po.nombre as Nombre, mt.mt as Movimientos from pokemon po
inner join pokemon_movimiento_forma pmf on po.numero_pokedex=pmf.numero_pokedex
inner join mt on pmf.id_forma_aprendizaje=mt.id_forma_aprendizaje
where po.nombre="Pikachu" group by mt.mt order by mt.mt;
-- 16.1 Otra Opcion --
select m.nombre as 'Nombre de ataque', p.nombre as 'Pokemon', tfa.tipo_aprendizaje as 'Tipo de aprendizaje' 
from pokemon p, movimiento m, pokemon_movimiento_forma pmf, forma_aprendizaje fa, tipo_forma_aprendizaje tfa
where p.numero_pokedex = pmf.numero_pokedex
and m.id_movimiento = pmf.id_movimiento
and pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje
and fa.id_tipo_aprendizaje = tfa.id_tipo_aprendizaje
and p.nombre = 'Pikachu'
and tfa.tipo_aprendizaje = 'MT';
-- 17. Movimientos de tipo normal que aprende pikachu por nivel.
select po.nombre as Nombre, na.nivel as Niveles from pokemon po
inner join pokemon_movimiento_forma pmf on po.numero_pokedex=pmf.numero_pokedex
inner join nivel_aprendizaje na on pmf.id_forma_aprendizaje=na.id_forma_aprendizaje
where po.nombre="Pikachu" group by na.id_forma_aprendizaje order by na.nivel;
-- 17.1 Otra Opcion --
select m.nombre as 'Nombre de ataque', p.nombre as 'Pokemon', t.nombre as 'Tipo de ataque', na.nivel as 'Nivel'
from pokemon p, movimiento m, pokemon_movimiento_forma pmf, forma_aprendizaje fa, tipo_forma_aprendizaje tfa, nivel_aprendizaje na, tipo t
where p.numero_pokedex = pmf.numero_pokedex
and m.id_movimiento = pmf.id_movimiento
and pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje
and pmf.id_forma_aprendizaje = na.id_forma_aprendizaje
and fa.id_tipo_aprendizaje = tfa.id_tipo_aprendizaje
and m.id_tipo = t.id_tipo
and p.nombre = 'Pikachu'
and t.nombre = 'Normal' order by na.nivel;
-- 18. Movimientos de efecto secundario cuya probabilidad sea mayor al 30%.
select mov.nombre as Movimiento, mes.probabilidad as Probabilidad from movimiento mov
inner join movimiento_efecto_secundario mes on mov.id_movimiento=mes.id_movimiento
where mes.probabilidad > 30 order by Movimiento;
-- 19. Pokemon que evolucionan por piedra.
select po.nombre as Nombre, te.tipo_evolucion as Evolucion from pokemon po
inner join pokemon_forma_evolucion pfe on po.numero_pokedex=pfe.numero_pokedex
inner join forma_evolucion fe on pfe.id_forma_evolucion=fe.id_forma_evolucion
inner join tipo_evolucion te on fe.tipo_evolucion=te.id_tipo_evolucion
where te.tipo_evolucion="Piedra" group by po.nombre order by po.nombre;
-- 20. Pokemon que no pueden evolucionar.
select po.nombre as Nombre, te.tipo_evolucion as Evolucion from pokemon po
inner join pokemon_forma_evolucion pfe on po.numero_pokedex=pfe.numero_pokedex
inner join forma_evolucion fe on pfe.id_forma_evolucion=fe.id_forma_evolucion
inner join tipo_evolucion te on fe.tipo_evolucion=te.id_tipo_evolucion
where te.tipo_evolucion is null order by po.nombre;
-- REVISAR
-- 20.1 Otra Opcion --
select p.nombre
from pokemon p inner join evoluciona_de ed
on p.numero_pokedex = ed.pokemon_evolucionado;
-- 21. Cantidad de los pokemon de cada tipo.
select t.nombre as Tipo, count(po.nombre) as CantidadPokemon from pokemon po
inner join pokemon_tipo pt on po.numero_pokedex=pt.numero_pokedex
inner join tipo t on pt.id_tipo=t.id_tipo
group by t.nombre order by t.nombre;