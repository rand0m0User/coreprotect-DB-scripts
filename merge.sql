ATTACH DATABASE 'F:\soycraft_2\data\plugins\CoreProtect\database.db' AS db2;

--add all "new" players to co_user
INSERT OR IGNORE INTO co_user (time, user, uuid) SELECT time, user, uuid FROM co_user
WHERE NOT EXISTS (SELECT 1 FROM co_user WHERE co_user.user = db2.co_user.user);

--merge any missing artmap entries (is this even used?)
INSERT OR IGNORE INTO co_art_map (art) SELECT art FROM co_art_map
WHERE NOT EXISTS (SELECT 1 FROM co_art_map WHERE co_art_map.art = db2.co_art_map.art);

--merge any missing world entries (is this even used?)
INSERT OR IGNORE INTO co_world (world) SELECT world FROM co_world
WHERE NOT EXISTS (SELECT 1 FROM co_world WHERE co_world.world = db2.co_world.world);

--merge any missing blockdata entries
INSERT OR IGNORE INTO co_blockdata_map (data) SELECT data FROM co_blockdata_map
WHERE NOT EXISTS (SELECT 1 FROM co_blockdata_map WHERE co_blockdata_map.data = db2.co_blockdata_map.data);

--merge any missing entitymap entries
INSERT OR IGNORE INTO co_entity_map (entity) SELECT entity FROM co_entity_map
WHERE NOT EXISTS (SELECT 1 FROM co_entity_map WHERE co_entity_map.entity = db2.co_entity_map.entity);

--merge the chat table from DB2 to this database
INSERT INTO co_chat (time,user,wid,x,y,z,message) SELECT time, 
	(SELECT id FROM co_user WHERE user = (SELECT user FROM co_user WHERE co_user.id = db2.co_chat.user)) as user,
	(SELECT wid FROM co_world WHERE world = (SELECT world FROM co_world WHERE co_world.world = db2.co_world.world)) as wid,
	x, y, z, message
	FROM co_chat;
	
--merge the skull table from DB2 to this database (is this even used?)
INSERT INTO co_skull (time,owner) SELECT time, owner
	FROM co_skull;

--merge the command table from DB2 to this database
INSERT INTO co_command (time,user,wid,x,y,z,message) SELECT time, 
	(SELECT id FROM co_user WHERE user = (SELECT user FROM co_user WHERE co_user.id = db2.co_command.user)) as user,
	(SELECT wid FROM co_world WHERE world = (SELECT world FROM co_world WHERE co_world.world = db2.co_world.world)) as wid,
	x, y, z, message
	FROM co_command;

--merge the sign table from DB2 to this database
INSERT INTO co_sign (time,user,wid,x,y,z,action,color,color_secondary,data,waxed,face,line_1,line_2,line_3,line_4,line_5,line_6,line_7,line_8) SELECT time, 
	(SELECT id FROM co_user WHERE user = (SELECT user FROM co_user WHERE co_user.id = db2.co_sign.user)) as user,
	(SELECT wid FROM co_world WHERE world = (SELECT world FROM co_world WHERE co_world.world = db2.co_world.world)) as wid,
	x, y, z, action, color, color_secondary, data, waxed, face, line_1, line_2, line_3, line_4, line_5, line_6, line_7, line_8
	FROM co_sign;
		
--merge the item table from DB2 to this database
INSERT INTO co_item (time,user,wid,x,y,z,type,data,amount,action,rolled_back) SELECT time, 
	(SELECT id FROM co_user WHERE user = (SELECT user FROM co_user WHERE co_user.id = db2.co_item.user)) as user,
	(SELECT wid FROM co_world WHERE world = (SELECT world FROM co_world WHERE co_world.world = db2.co_world.world)) as wid,
	x, y, z,
	(SELECT id FROM co_material_map WHERE material = (SELECT material FROM co_material_map WHERE co_material_map.id = db2.co_item.type)) as type,
		data, amount, action, rolled_back
	FROM co_item;

--merge the entity table from DB2 to this database (how do you even look it up?)
INSERT INTO co_entity (time,data) SELECT time, data
	FROM co_entity;

--merge the block table from DB2 to this database
INSERT INTO co_block (time,user,wid,x,y,z,type,data,meta,blockdata,action,rolled_back) SELECT time, 
	(SELECT id FROM co_user WHERE user = (SELECT user FROM co_user WHERE co_user.id = db2.co_block.user)) as user,
	(SELECT wid FROM co_world WHERE world = (SELECT world FROM co_world WHERE co_world.world = db2.co_world.world)) as wid,
	x, y, z,
	(SELECT id FROM co_material_map WHERE material = (SELECT material FROM co_material_map WHERE co_material_map.id = db2.co_block.type)) as type,
	(SELECT id FROM co_blockdata_map WHERE data = (SELECT data FROM co_blockdata_map WHERE co_blockdata_map.id = db2.co_block.data)) as type,
		meta, blockdata, action, rolled_back
	FROM co_block;

--merge the container table from DB2 to this database
INSERT INTO co_container (time,user,wid,x,y,z,type,data,amount,metadata,action,rolled_back) SELECT time, 
	(SELECT id FROM co_user WHERE user = (SELECT user FROM co_user WHERE co_user.id = db2.co_container.user)) as user,
	(SELECT wid FROM co_world WHERE world = (SELECT world FROM co_world WHERE co_world.world = db2.co_world.world)) as wid,
	x, y, z,
	(SELECT id FROM co_material_map WHERE material = (SELECT material FROM co_material_map WHERE co_material_map.id = db2.co_container.type)) as type,
		data, amount, metadata, action, rolled_back
	FROM co_container;

DETACH DATABASE db2;