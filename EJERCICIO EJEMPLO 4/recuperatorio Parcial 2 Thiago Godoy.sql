SELECT e.descripcion AS NombreEmpresa,v.numero numeroViaje,v.fechaHoraSalida AS FechaYHoraSalida,v.numeroUnidad AS NumeroUnidad,v.fechaHoraSalida AS salida
FROM empresa e INNER JOIN viaje v ON v.ID=e.viajeID
WHERE NombreEmpresa='TALP' AND YEAR(salida)=2020 AND MONTH(salida)=01 AND HOUR(salida)<12


SELECT e.descripcion AS NombreEmpresa,v.numero numeroViaje,v.fechaHoraSalida AS FechaYHoraSalida,v.fechaHoraSalida AS salida,COUNT (*) AS pasajero
FROM empresa e INNER JOIN viaje v ON v.ID=e.viajeID
					INNER JOIN pasaje pa ON pa.ID=v.pasajeID
					INNER JOIN persona p ON pasajeroID=pa.ID
GROUP BY v.ID
HAVING NombreEmpresa='TALP' AND (salida BETWEEN '20200101 00:00:00' AND '20200131 23:59:59')
ORDER BY numeroViaje DESC 


SELECT e.descripcion AS NombreEmpresa,v.numero AS numero,v.fechaHoraSalida AS FechaHoraSalida,CONCAT(p.nombre,' ',p.apellido) NombreApellidoChofer
FROM viaje v INNER JOIN ciudad co ON v.ID=c.origenID
				 INNER JOIN persona p choferID=v.ID
				 INNER JOIN empresa e v.ID=e.viajeID
WHERE co.nombre='La Plata'

UNION 

SELECT e.descripcion AS NombreEmpresa,v.numero AS numero,v.fechaHoraSalida AS FechaHoraSalida,CONCAT(p.nombre,' ',p.apellido) NombreApellidoChofer
FROM viaje v INNER JOIN ciudad cd ON v.ID=c.destinoID
				 INNER JOIN persona p choferID=v.ID
				 INNER JOIN empresa e v.ID=e.viajeID
WHERE cd.nombre='Quilmes'


SELECT CONCAT(pe.nombre,' ',pe.apellido), COUNT(*) AS cantidad_viajes
persona pe INNER JOIN pasaje pa ON pe.pasajeroID=pa.ID
			  INNER JOIN viaje v ON v.ID=pa.viajeID
WHERE YEAR(v.fechaSalida)=2000


SELECT CONCAT(pe.nombre,' ',pe.apellido),year(v.fechaHoraSalida) año, COUNT(*) AS cantidad_viajes
persona pe INNER JOIN pasaje pa ON pe.pasajeroID=pa.ID
			  INNER JOIN viaje v ON v.ID=pa.viajeID
GROUP BY v.ID

