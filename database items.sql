INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES ('fish', 'Fish', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES ('fishbait', 'Fish Bait', 30, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES ('fishingrod', 'Fishing Rod', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES ('shark', 'Shark', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES ('turtle', 'Sea Turtle', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES ('turtlebait', 'Turtle Bait', 10, 0, 1);

INSERT INTO `shops` (store, item, price) VALUES  ('TwentyFourSeven','fishingrod',500);
INSERT INTO `shops` (store, item, price) VALUES  ('TwentyFourSeven','fishbait',50);
INSERT INTO `shops` (store, item, price) VALUES  ('TwentyFourSeven','turtlebait',150);
INSERT INTO `shops` (store, item, price) VALUES  ('RobsLiquor','fishingrod',500);
INSERT INTO `shops` (store, item, price) VALUES  ('RobsLiquor','fishbait',50);
INSERT INTO `shops` (store, item, price) VALUES  ('RobsLiquor','turtlebait',150);
INSERT INTO `shops` (store, item, price) VALUES  ('LTDgasoline','fishingrod',500);
INSERT INTO `shops` (store, item, price) VALUES  ('LTDgasoline','fishbait',50);
INSERT INTO `shops` (store, item, price) VALUES  ('LTDgasoline','turtlebait',150);