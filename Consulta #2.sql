/*
mostrar todos los despachos del año 2018 cuyo origen sea zona comun y cuyo destino sea san martin.
se requiere ver fecha, numero, origen, destino y el nombre apellido del practico 
nombre y apellido estan en practico 
origen destino esta en otra tabla 
*/

SELECT DATE(d.fechaHora) fecha,d.numero Num, ori.descripcion Ori,des.descripcion Destino,p.nombreApellido Capitan 
FROM despacho AS d INNER JOIN origendestino AS o ON d.desdeID=o.ID 
					    INNER JOIN origendestino AS o ON d.hastaID=d.ID 
					    INNER JOIN practico p ON d.practicoID=p.ID
/*
las tablas que necesito fecha y numero estan en despacho 
origen esta en origen
destino esta en descripcion de destino 
*/

WHERE YEAR(d.fechaHora)=2018 AND 
#este es el filtro para los años 2018 tambien existe day y month 
		ori.descripcion='ZONA COMUN' AND 
#un filtro para todos los origenes que sean ZONA COMUN
		des.descripcion='SAN MARTIN'
/*		
mostrar todos los despachos que se hayan hecho con practicos propios 
se requiere ver fecha,numero,la razon social de la empresa maritima
nombre y apellido del practico. ordenar por fecha de menor a mayor 
*/

SELECT cast(d.fechaHora AS DATE) fecha, d.numero Numero,am.descipcion razonSocial,p.nombreApellido nombreApellido 
FROM despacho d INNER JOIN agenciamaritima am ON d.agenciaMaritimaID=am.id
					 INNER JOIN practico p ON d.practicoID=p.ID
#si tenes la fk dentro de la tabla que estas trabajando tenes que asociarla a la pk (id) que esta en otra tabla
WHERE d.practicoPropio=1
#esto devuelve los despachos que sean propios (osea 1 en este caso osea true)
ORDER BY fecha ASC 

/*
mostrar la cantidad de viajes que realizo cada empresa de lanchas durante el año 2019
se quiere ver el nombre de la empresa y la cantidad de viajes
*/

SELECT l.descripcion nombreEmpresa, COUNT(*) cantidadViajes
FROM despacho d INNER JOIN lancha l ON d.lanchaEmbraqueID=l.ID
WHERE YEAR(d.fechaHora)=2019
GROUP BY l.ID 
#esto separa la cantidad de empresas que tengan lanchas 

/*
mostrar la cantidad de viajes que realizo cada empresa de remis durante el año 2019 
se requiere ver el nombre de la empresa y la cantidad de viajes 
*/ 

SELECT *
FROM despacho d INNER JOIN despachoremis dr ON d.ID=dr.despachoID 
					 INNER JOIN remis r ON dr.remisID=r.ID
WHERE YEAR(d.fechaHora)=2019 
GROUP BY r.ID 

/*
mostrar las empresas a las que se le facturo mas de 1 millon de dolares durante el año 2019
se requiere ver la razon social de la empresa y el importe facturado
*/

SELECT am.descripcion agenciamaritima,SUM(t.importetotaldolar) totalFacturado
FROM transaccion t INNER JOIN agenciaMaritima am ON t.agenciamaritimaID=am.ID
#la factura asociada a agenciamaritima, FK=PK
WHERE t.fecha BETWEEN '20190101' AND '20191231' 
#todas las ventas que fueron hechas en ese lapso de tiempo basicamente 2019 
GROUP BY am.ID
HAVING totalFacturado>1000000
#el having es un filtro (como un where) pero para lo agrupado (group by)

/*
si quisiera el total facturado de TODOS los años seria algo asi
*/

SELECT am.descripcion agenciamaritima,YEAR(t.fecha) año, SUM(t.importetotaldolar) totalFacturado
FROM transaccion t INNER JOIN agenciaMaritima am ON t.agenciamaritimaID=am.ID
GROUP BY am.ID,YEAR(t.fecha)
HAVING totalFacturado>1000000

/*mostrar los importes facturados por cada concepto durante el mes de enero de 2018
se requiere ver el nombre del concepto y el importe facturado. 
ordenar el resultado por importe de mayor a menor 
*/

