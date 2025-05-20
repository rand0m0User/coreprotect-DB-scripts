--an SQL implementation of the sign distance function for a circle, replace "1000" with your target radius
--most tables have the same x, y, and z schema, so you can replace "co_block" with the desired table if need be
DELETE FROM co_block WHERE SQRT(POWER(<insert target X pos here> - x, 2) + POWER(<insert target z pos here> - z, 2)) <= 1000;
