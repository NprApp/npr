CREATE TABLE `schema_migrations` (`filename` varchar(255) NOT NULL PRIMARY KEY);
CREATE TABLE `cards` (`id` integer NOT NULL PRIMARY KEY AUTOINCREMENT, `number` integer);
INSERT INTO `schema_migrations` (`filename`) VALUES ('20150711214223_create_cards.rb');