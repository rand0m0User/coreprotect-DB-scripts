--book bans can potentially linger in a coreprotect database, bloasting the size a bit due to their 2MB+ NBT data
SELECT * FROM co_container WHERE LENGTH(metadata) >= 100000 
	AND (type IS (SELECT id FROM co_material_map WHERE material IS "minecraft:writable_book") 
		OR type IS (SELECT id FROM co_material_map WHERE material IS "minecraft:written_book"));