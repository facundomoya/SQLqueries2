--CONSIGNAS DEL TRABAJO DE SUBCONSULTAS
USE CoderHouse;

--1)Renombrar cuantos cursos y carreras tiene el area de Data. Renombrar la nueva columna como cant de asignaturas. Keywords: Tipo, Area, Asignaturas
SELECT tipo, count(Tipo) as conteo
From Asignaturas
where Area=5
group by Tipo

--2)Se requiere saber cual es el nombre, el documento y el telefono de los estudiantes que son profesionales en agronomia y que nacieron entre el año 1970 y el 2000
SELECT * FROM Estudiantes
SELECT Nombre, Documento, Telefono,[Fecha de Nacimiento]
FROM Estudiantes
where Profesion='6' and [Fecha de Nacimiento] between '1970-01-01' and '2000-01-01'

/*3)Se requiere de un listado de los docentes que ingresaron en el año 2021 y concatenenar los campos nombre y apellido. 
El resultado debe utilizar un separador: guion(-).Renombrar la nueva columna como Nombres_Apellidos. Los resultados
de la nueva columna deben estar en mayusculas. Keywords: Staff, Fecha Ingreso, Nombre, Apellido*/
SELECT UPPER(CONCAT(Nombre,'-',Apellido)) as Nombres_Apellidos, [Fecha Ingreso]
FROM Staff
WHERE [Fecha Ingreso] BETWEEN '2021-01-01' and '2021-12-12'

/*4)Indicar la cantidad de encargados de docentes y de tutores. Renombrar la columna como CantEncargados.
Quitar la palabra "Encargado" en cada uno de los registros. Renombrar la columna como NuevoTipo.
Keywords: Encargado,Tipo,EncargadoID*/
SELECT (COUNT(Tipo)) as CantEncargados,Tipo,REPLACE(Tipo,'Encargado',' ') as NuevoTipo
FROM Encargado
GROUP BY Tipo

/*5)Indicar cual es el precio promedio de las carreras y los cursos por jornada. Renombrar la nueva columna como Promedio.
Ordenar los promedios de Mayor a menor. Keywords: Tipo,Jornada,Asignaturas*/
SELECT Tipo,Jornada,AVG(Costo) as Promedio
FROM Asignaturas
GROUP BY Tipo,Jornada
order by Promedio DESC

/*6)Se requiere calcular la edad de los estudiantes en una nueva columna.Renombrar a la nueva columna Edad.Filtrar solo los que son
mayores de 18 años. Ordenar de menor a mayor*. Keywords: Fecha de nacimiento, Estudiantes*/
SELECT Nombre,Apellido,[Fecha de Nacimiento],  DATEDIFF(YEAR,[Fecha de Nacimiento],'2021-12-10') as Edad
FROM Estudiantes
WHERE [Fecha de Nacimiento] < '2003-12-10'
ORDER BY Edad ASC

/*7)Se requiere saber el Nombre,el correo, la camada y la fecha de ingreso de personas del staff que
contienen correo .edu y su DocenteID sea mayor o igual que 100. Keywords: Staff,correo, DocentesID*/
SELECT Nombre,Apellido,Correo,Camada,[Fecha Ingreso],DocentesID
FROM Staff
where RIGHT(Correo,4) = '.edu' and DocentesID >= 100

/*8)Se requiere conocer el documento, el domicilio el codigo postal y el nombre de los primeros estudiantes que se
registraron en la plataforma. Keywords: Documento,Estudiantes,Fecha Ingreso*/
SELECT [Fecha Ingreso],Documento,Domicilio,[Codigo Postal],Nombre
FROM Estudiantes
WHERE [Fecha Ingreso] =(select Min([Fecha Ingreso]) from Estudiantes)

/*9)Indicar el nombre, apellido y documento de los docentes y tutores que tienen asignaturas "UX".
Keywords: Staff, Asignaturas, Nombre, Apellido*/
SELECT Nombre,Apellido,Documento
FROM Staff
WHERE Asignatura in (SELECT AsignaturasID from Asignaturas where nombre like ('%UX%'))

/*10)Se desea calcular el 25% de aumento para las asignaturas del area de marketing de la jornada mañana
se deben traer todos los campos,mas el de los calculos correspondientes, el porcentaje y el Nuevo costo
debe estar en decimal con 3 digitos.
Renombrar el calculo del porcentaje con el nombre porcentaje y la suma del costo mas el porcentaje por NuevoCosto.
Keywords:Asignaturas, Costo, Area, Jornada, Nombre*/
SELECT Nombre,Jornada,Costo,LEFT(Costo*0.25,5) as Porcentaje,LEFT(Costo+Costo*0.25,6) as NuevoCosto
FROM Asignaturas
WHERE (Nombre='Maketing Digital' and Jornada='Manana')