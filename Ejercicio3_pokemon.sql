-- ## POKEMON ##
-- 1. Nombre de todos los pokemon
select nombre as Nombre from pokemon order by nombre;
-- 2. Pokemon que pesen menos de 10k.
select nombre as Nombre, peso as Peso_Kg from pokemon 
where peso < 10 order by nombre;
-- 3. Pokemon de tipo agua.
select tipo.nombre as Tipo , pokemon.nombre as Nombre from pokemon
inner join pokemon_tipo on pokemon.numero_pokedex=pokemon_tipo.numero_pokedex
inner join tipo on pokemon_tipo.id_tipo=tipo.id_tipo
where tipo.nombre="Agua" order by nombre;
-- 4. Pokemon de tipo agua, fuego o tierra ordenados por tipo.
select tipo.nombre as Tipo , pokemon.nombre as Nombre from pokemon
inner join pokemon_tipo on pokemon.numero_pokedex=pokemon_tipo.numero_pokedex
inner join tipo on pokemon_tipo.id_tipo=tipo.id_tipo order by tipo, nombre;
-- 5. Pokemon que son de tipo fuego y volador.
select tipo.nombre as Tipo , pokemon.nombre as Nombre from pokemon
inner join pokemon_tipo on pokemon.numero_pokedex=pokemon_tipo.numero_pokedex
inner join tipo on pokemon_tipo.id_tipo=tipo.id_tipo 
where tipo.nombre in ("Fuego","Volador") order by tipo, nombre;
-- 6. Pokemon con una estadística base de ps mayor que 200.
select pokemon.nombre as Nombre, estadisticas_base.ps from pokemon
inner join estadisticas_base on pokemon.numero_pokedex=estadisticas_base.numero_pokedex
where estadisticas_base.ps > 200;
-- 7. Datos(nombre, peso, altura) de la prevolución de Arbok.
select p.nombre as Nombre, p.peso as Peso, p.altura as Altura from pokemon p
inner join evoluciona_de e on p.numero_pokedex = e.pokemon_origen
inner join pokemon p1 on e.pokemon_evolucionado = p1.numero_pokedex
where p1.nombre = "Arbok";
-- 8. Pokemon que evolucionan por intercambio.
select pokemon.nombre as Nombre, tipo_evolucion.tipo_evolucion as Evolucion from pokemon
inner join pokemon_forma_evolucion on pokemon.numero_pokedex=pokemon_forma_evolucion.numero_pokedex
inner join forma_evolucion on pokemon_forma_evolucion.id_forma_evolucion=forma_evolucion.tipo_evolucion
inner join tipo_evolucion on forma_evolucion.tipo_evolucion=tipo_evolucion.id_tipo_evolucion
where tipo_evolucion.tipo_evolucion="Intercambio" order by Nombre;
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
select pokemon.nombre as Nombre, movimiento.nombre as Movimientos from pokemon
inner join pokemon_movimiento_forma on pokemon.numero_pokedex=pokemon_movimiento_forma.numero_pokedex
inner join movimiento on pokemon_movimiento_forma.id_movimiento=movimiento.id_movimiento
where pokemon.nombre="Pikachu" group by movimiento.nombre order by movimiento.nombre;
-- REVISAR
-- 16. Movimientos que aprende pikachu por MT (tipo de aprendizaje).
select pokemon.nombre as Nombre, mt.mt as Movimientos from pokemon
inner join pokemon_movimiento_forma on pokemon.numero_pokedex=pokemon_movimiento_forma.numero_pokedex
inner join mt on pokemon_movimiento_forma.id_forma_aprendizaje=mt.id_forma_aprendizaje
where pokemon.nombre="Pikachu" group by mt.mt order by mt.mt;
-- REVISAR
-- 17. Movimientos de tipo normal que aprende pikachu por nivel.
select pokemon.nombre as Nombre, nivel_aprendizaje.nivel as Niveles from pokemon
inner join pokemon_movimiento_forma on pokemon.numero_pokedex=pokemon_movimiento_forma.numero_pokedex
inner join nivel_aprendizaje on pokemon_movimiento_forma.id_forma_aprendizaje=nivel_aprendizaje.id_forma_aprendizaje
where pokemon.nombre="Pikachu" group by nivel_aprendizaje.id_forma_aprendizaje order by nivel_aprendizaje.nivel;
-- REVISAR
-- 18. Movimientos de efecto secundario cuya probabilidad sea mayor al 30%.
select movimiento.nombre as Movimiento, movimiento_efecto_secundario.probabilidad as Probabilidad from movimiento
inner join movimiento_efecto_secundario on movimiento.id_movimiento=movimiento_efecto_secundario.id_movimiento
where movimiento_efecto_secundario.probabilidad > 30 order by Movimiento;
-- 19. Pokemon que evolucionan por piedra.
select pokemon.nombre as Nombre, tipo_evolucion.tipo_evolucion as Evolucion from pokemon
inner join pokemon_forma_evolucion on pokemon.numero_pokedex=pokemon_forma_evolucion.numero_pokedex
inner join forma_evolucion on pokemon_forma_evolucion.id_forma_evolucion=forma_evolucion.id_forma_evolucion
inner join tipo_evolucion on forma_evolucion.tipo_evolucion=tipo_evolucion.id_tipo_evolucion
where tipo_evolucion.tipo_evolucion="Piedra" group by pokemon.nombre order by pokemon.nombre;
-- 20. Pokemon que no pueden evolucionar.
select pokemon.nombre as Nombre, tipo_evolucion.tipo_evolucion as Evolucion from pokemon
inner join pokemon_forma_evolucion on pokemon.numero_pokedex=pokemon_forma_evolucion.numero_pokedex
inner join forma_evolucion on pokemon_forma_evolucion.id_forma_evolucion=forma_evolucion.id_forma_evolucion
inner join tipo_evolucion on forma_evolucion.tipo_evolucion=tipo_evolucion.id_tipo_evolucion
where tipo_evolucion.tipo_evolucion is null order by pokemon.nombre;
-- REVISAR
-- 21. Cantidad de los pokemon de cada tipo.
select tipo.nombre as Tipo, count(pokemon.nombre) as CantidadPokemon from pokemon
inner join pokemon_tipo on pokemon.numero_pokedex=pokemon_tipo.numero_pokedex
inner join tipo on pokemon_tipo.id_tipo=tipo.id_tipo
group by tipo.nombre order by tipo.nombre;