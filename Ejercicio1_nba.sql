-- ## NBA ##
-- 1. Listado Jugadores
select * from jugadores order by nombre;
-- 2. Jugadores Pivot("C") y Peso > 200 Kgs.
select * from jugadores where Posicion = "C" and Peso > 200 order by nombre;
-- 3. Listado Equipos.
select * from equipos order by Nombre;
-- 4. Listado Equipos del Este.
select * from equipos where Conferencia="East" order by Nombre;
-- 5. Listado Equipos Ciudad empiea con "C".
select * from equipos where Ciudad like "C%" order by Nombre;
-- 6. Listado Jugadores y Equipo.
select Nombre,Nombre_equipo from jugadores order by Nombre_equipo,Nombre;
-- 7. Jugadores Equipo Raptors.
select Nombre,Nombre_equipo from jugadores where Nombre_equipo="Raptors" order by Nombre;
-- 8. Puntos por Partido de Pau Gasol.
select jugador, jugadores.Nombre, Puntos_por_partido from estadisticas inner join jugadores 
on jugadores.codigo = estadisticas.jugador where jugadores.Nombre ="Pau Gasol";
-- 9. Puntos por Partido de Pau Gasol Temporada 04/05.
select jugador, jugadores.Nombre, Puntos_por_partido from estadisticas inner join jugadores 
on jugadores.codigo = estadisticas.jugador where jugadores.Nombre ="Pau Gasol" 
and estadisticas.temporada="04/05";
-- 10. Puntos Jugadores en toda su carrera.
select jugador, jugadores.Nombre, round(sum(Puntos_por_partido)) as TotalPuntos from estadisticas inner join jugadores 
on jugadores.codigo = estadisticas.jugador group by jugador;
-- 11. Cantidad Jugadores por Equipo.
select Nombre_equipo,count(*) as CantidadJugadores from jugadores group by Nombre_equipo order by Nombre_equipo;
-- 12. Jugador con mas Puntos.
select jugador, jugadores.Nombre, round(sum(Puntos_por_partido)) as TotalPuntos from estadisticas inner join jugadores 
on jugadores.codigo = estadisticas.jugador group by jugador order by sum(Puntos_por_partido) desc limit 1 ;
-- 13. Nombre Equipo, Conferencia y División jugador más alto de la NBA.
select jugadores.Nombre as Jugador, jugadores.Nombre_equipo,equipos.Conferencia,equipos.Division,jugadores.Altura from jugadores inner join equipos on 
jugadores.Nombre_equipo = equipos.Nombre order by jugadores.Altura desc limit 1;
-- 14. Partido o partidos(equipo_local,equipo_visitante y diferencia) con mayor diferencia de puntos.
select equipo_local,equipo_visitante,puntos_local,puntos_visitante,round(abs(puntos_local-puntos_visitante)) 
as DiferenciaPuntos from partidos order by DiferenciaPuntos desc limit 10;
-- 15. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), en caso de empate sera null.
select equipo_local,equipo_visitante,puntos_local,puntos_visitante, 
case 
when puntos_local> puntos_visitante then equipo_local
when puntos_visitante> puntos_local then equipo_visitante
when puntos_local= puntos_visitante then null
end as EquipoGanador
from partidos;

