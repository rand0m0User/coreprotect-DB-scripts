--clean book bans or heavy NBT objects
DELETE FROM co_container WHERE LENGTH(metadata) >= 100000 
	AND (type IS (SELECT id FROM co_material_map WHERE material IS "minecraft:writable_book") 
		OR type IS (SELECT id FROM co_material_map WHERE material IS "minecraft:written_book"));