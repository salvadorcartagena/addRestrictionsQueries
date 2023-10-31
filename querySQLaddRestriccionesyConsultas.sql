select * from clientes
-- Agregar clave foránea en la tabla Productos
ALTER TABLE productos
ADD FOREIGN KEY (categoria_id) REFERENCES categorias(id);

-- Agregar clave foránea en la tabla Stocks
ALTER TABLE Stocks
ADD FOREIGN KEY (sucursal_id) REFERENCES Sucursales(id),
ADD FOREIGN KEY (producto_id) REFERENCES Productos(id);

-- Agregar clave foránea en la tabla Ordenes
ALTER TABLE Ordenes
ADD FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
ADD FOREIGN KEY (sucursal_id) REFERENCES Sucursales(id);

-- Agregar clave foránea en la tabla Items
ALTER TABLE Items
ADD FOREIGN KEY (orden_id) REFERENCES Ordenes(id),
ADD FOREIGN KEY (producto_id) REFERENCES Productos(id);

--Calcular el precio promedio de los productos en cada categoría
SELECT c.Nombre AS Categorias, AVG(p.Precio_unitario) AS PrecioPromedio
FROM Productos p
JOIN Categorias c ON p.categoria_id = c.id
GROUP BY c.Nombre;

--Obtener la cantidad total de productos en stock por categoría
SELECT c.Nombre AS Categoria, SUM(s.Cantidad) AS Cantidad_Total
FROM Stocks s
JOIN Productos p ON s.producto_id = p.id
JOIN Categorias c ON p.categoria_id = c.id
GROUP BY c.Nombre;

--Calcular el total de ventas por sucursal
SELECT su.Nombre AS Sucursal, SUM(i.Monto_Venta) AS Ventas_Totales
FROM Sucursales su
JOIN Ordenes o ON o.sucursal_id = su.id
JOIN Items i ON i.orden_id = o.id
GROUP BY su.Nombre;

--Obtener el cliente que ha realizado el mayor monto de compras
SELECT c.Nombre AS Cliente, SUM(i.Monto_Venta) AS Monto_Compras
FROM Clientes c
JOIN Ordenes o ON o.cliente_id = c.id
JOIN Items i ON i.orden_id = o.id
GROUP BY c.Nombre
ORDER BY Monto_Compras DESC
LIMIT 1;

