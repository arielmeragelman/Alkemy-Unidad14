--Listar los nombres de los proveedores cuya ciudad contenga la cadena de texto “Ramos”.
select Nombre,CodProv as 'Codigo Proveedor',Ciudad from Proveedor where Ciudad like '%Ramos%'

--Listar los códigos de los materiales que provea el proveedor 4 y no los provea el proveedor 5. Se debe resolver de 3 formas.
SELECT CodMat
FROM Provisto_por
WHERE CodProv = 4
EXCEPT
SELECT CodMat
FROM Provisto_por
WHERE CodProv = 5

SELECT CodMat
FROM Provisto_por pp
WHERE CodProv = 4 AND NOT EXISTS (SELECT 1
FROM Provisto_por pp2
WHERE CodProv = 5 and pp.CodMat=pp2.CodMat)

SELECT CodMat
FROM Provisto_por
WHERE CodProv = 4 AND CodProv NOT IN 
(SELECT CodMat FROM Provisto_por
WHERE CodProv = 5)


-- Listar los materiales, código y descripción, provistos por proveedores de la ciudad de Ramos Mejía.
SELECT m.CodMat,m.Descripcion
from Material m
inner join  Provisto_Por pp 
on pp.CodMat = m.CodMat 
inner join Proveedor p 
on p.CodProv = pp.CodProv 
where trim(lower(p.Ciudad)) like 'Ramos Mej_a'

-- Listar los proveedores y materiales que provee. La lista resultante debe incluir a aquellos proveedores que no proveen ningún material.
SELECT p.CodProv,p.Nombre,m.Descripcion
from Proveedor p 
left join Provisto_Por pp 
on p.CodProv = pp.CodProv 
left join Material m 
on pp.CodMat = m.CodMat 

--Listar los artículos que cuesten más de $30 o que estén compuestos por el material 2.
SELECT a.Descripcion,a.CodArt,a.Precio,cp.CodMat
from Articulo a 
inner join Compuesto_Por cp 
on a.CodArt = cp.CodArt 
where a.Precio >30 or cp.CodMat = 2

--Listar los artículos de Mayor precio.
SELECT Descripcion,CodArt,Precio
from Articulo
order by Precio Desc


--Listar los proveedores que proveen más de 3 materiales
SELECT p.CodProv,p.Nombre,COUNT(pp.CodMat) as CantMateriales
from Proveedor p 
inner join Provisto_Por pp 
on p.CodProv = pp.CodProv
group by p.CodProv,p.Nombre
having COUNT(pp.CodMat) > 3

--Crear una vista para el caso de los proveedores que proveen más de 4 materiales. Mostrar la forma de invocar esa vista.

CREATE VIEW v_cantidad_prov_mas_3_art as (
SELECT p.CodProv,p.Nombre,COUNT(pp.CodMat) as CantMateriales
from Proveedor p 
inner join Provisto_Por pp 
on p.CodProv = pp.CodProv
group by p.CodProv,p.Nombre
having COUNT(pp.CodMat) > 3);

select Nombre from v_cantidad_prov_mas_3_art where CantMateriales > 9;



