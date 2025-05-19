
--TODO: [preformance] use joins
DELETE FROM co_block WHERE rolled_back IS 1
	OR user IS (SELECT id FROM co_user WHERE user IS "#piston")
	OR user IS (SELECT id FROM co_user WHERE user IS "#vine")
	OR user IS (SELECT id FROM co_user WHERE user IS "#dispenser")
	OR user IS (SELECT id FROM co_user WHERE user IS "#bamboo")
	OR user IS (SELECT id FROM co_user WHERE user IS "#decay")
	OR user IS (SELECT id FROM co_user WHERE user IS "Dispenser-Block"); --modispensermachanics dummy player

--TODO: [preformance] use joins
DELETE FROM co_container WHERE rolled_back IS 1 
	OR user IS (SELECT id FROM co_user WHERE user IS "#dispenser") 
	OR user IS (SELECT id FROM co_user WHERE user IS "#hopper");

--clean book bans or heavy NBT objects
DELETE FROM co_container WHERE LENGTH(metadata) >= 100000 
	AND (type IS (SELECT id FROM co_material_map WHERE material IS "minecraft:writable_book") 
		OR type IS (SELECT id FROM co_material_map WHERE material IS "minecraft:written_book"));

--prune commonly used useless to have around admin comands
DELETE FROM co_command WHERE message LIKE '%fill%' 
		OR message LIKE '%setblock%' 
		OR message LIKE '%kill%'
		OR message LIKE '%data modify%' 
		OR message LIKE '%execute%';

--place one of these at every public player farm
--DELETE FROM co_container WHERE wid IS 2 AND SQRT(POWER(0 - x, 2) + POWER(0 - z, 2)) <= 100;