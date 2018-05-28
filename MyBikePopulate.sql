-- Before all

-- Organization Insert
INSERT INTO Organization VALUES (1, 'GoodBike');
INSERT INTO Organization VALUES (2, 'Università degli studi di Padova');
INSERT INTO Organization VALUES (3, 'AcegasApsAmga');
INSERT INTO Organization VALUES (4, 'Comfordinord');
INSERT INTO Organization VALUES (5, 'InfocamerePD');
INSERT INTO Organization VALUES (6, 'Monte dei Paschi');

-- Subscription Insert
INSERT INTO Subscription VALUES (1, 'Yearly', 25, 'daily', 365, NULL);
INSERT INTO Subscription VALUES (2, 'Monthly', 10, 'daily', 30, NULL);
INSERT INTO Subscription VALUES (3, 'Weekly', 5, 'hourly', NULL, 168);
INSERT INTO Subscription VALUES (4, '4FORYOU', 8, 'hourly', NULL, 4);
INSERT INTO Subscription VALUES (5, '8FORYOU', 13, 'hourly', NULL, 8);

-- Payment Method Insert
INSERT INTO PaymentMethod VALUES (1, 'credit card');
INSERT INTO PaymentMethod VALUES (2, 'bank transfer');

-- Docking Station Insert
INSERT INTO DockingStation (station_name, columns_number, latitude, longitude) VALUES ('Sarpi', 12, 45.4170156, 11.8760725);
INSERT INTO DockingStation (station_name, columns_number, latitude, longitude) VALUES ('Mazzini', 14, 45.414069, 11.874284);
INSERT INTO DockingStation (station_name, columns_number, latitude, longitude) VALUES ('Giotto', 14, 45.413018, 11.87732);
INSERT INTO DockingStation (station_name, columns_number, latitude, longitude) VALUES ('Gasometro', 13, 45.411725, 11.882158);
INSERT INTO DockingStation (station_name, columns_number, latitude, longitude) VALUES ('Venezia / Colombo', 14, 45.410225, 11.892545);

-- Docking Point Insert
INSERT INTO DockingPoint (status, docking_station) VALUES ('enabled', 1);
INSERT INTO DockingPoint (status, docking_station) VALUES ('enabled', 1);
INSERT INTO DockingPoint (status, docking_station) VALUES ('enabled', 1);
INSERT INTO DockingPoint (status, docking_station) VALUES ('in maintenance', 1);
INSERT INTO DockingPoint (status, docking_station) VALUES ('enabled', 2);
INSERT INTO DockingPoint (status, docking_station) VALUES ('disabled', 2);
INSERT INTO DockingPoint (status, docking_station) VALUES ('enabled', 3);
INSERT INTO DockingPoint (status, docking_station) VALUES ('enabled', 3);
INSERT INTO DockingPoint (status, docking_station) VALUES ('enabled', 3);

-- Bike Insert
INSERT INTO Bike (last_service, status, model) VALUES ('2018-05-22', 'ok', 'typical');
INSERT INTO Bike (last_service, status, model) VALUES ('2018-05-20', 'ok', 'electric');
INSERT INTO Bike (last_service, status, model) VALUES ('2018-05-29', 'in maintenance', 'typical');
INSERT INTO Bike (last_service, status, model) VALUES ('2018-05-29', 'to be replaced', 'electric');
INSERT INTO Bike (last_service, status, model) VALUES ('2018-05-23', 'ok', 'typical');

-- Shop Insert
INSERT INTO Shop VALUES ('IT10390980018', 'Bicincittà srl', 'Via Morghen', '34', 'Torino', '10143', 'Actual provider of the bike sharing service');
INSERT INTO Shop VALUES ('IT09756440091', 'Bar all''angolo', 'Via Gradenigo', '8/B', 'Padova', '35123', 'Bar all''aperto');
INSERT INTO Shop VALUES ('IT08349880174', 'Mensa', 'Via Colombo', '4', 'Padova', '35124', 'Mensa universitaria');

-- Offer Insert
INSERT INTO Offer (reward_cost, description, shop) VALUES (100, 'Pranzo gratis', 'IT08349880174');
INSERT INTO Offer (reward_cost, description, shop) VALUES (600, 'Sconto 30% sull''abbonamento annuale', 'IT10390980018');

-- Customer Inserts
INSERT INTO Customer (customer_id, name, surname, date_birth, place_birth, sex, fiscal_code, street_name, street_number, city, zip, email, mobile_phone, password) VALUES ('19f8c9c8-14b2-43d9-b6a5-1d07268e840e', 'mario', 'rossi', '1970-03-23', 'padova', 'male', 'RSSMRA70C23G224H', 'via roma', '4', 'padova', '35100', 'mario.rossi@gmail.com', '3395678655', 'E21B6004DE3A3EA401B6CB0DCC38F386');

INSERT INTO Customer (customer_id, name, surname, date_birth, place_birth, sex, fiscal_code, street_name, street_number, city, zip, email, mobile_phone, password) VALUES ('ed8fa2aa-a868-4cb1-9705-e9b38aa26d88', 'giovanni', 'milanesi', '1983-03-22', 'padova', 'male', 'MLNGNN83C22G224O', 'via beltrame', '9', 'padova', '35100', 'giovanni.milanesi@yahoo.it', '3382278133', '3554A32D9AD6AE0C5074EDA60B5B19DB'); 

INSERT INTO Customer (customer_id, name, surname, date_birth, place_birth, sex, fiscal_code, street_name, street_number, city, zip, email, mobile_phone, password) VALUES ('062b665f-6284-4b77-ab18-72f08445145c', 'silvano', 'toscano', '1982-05-12', 'vicenza', 'male', 'TSCSVN82E12G224G', 'via altinate', '4', 'padova', '35100', 'silv.toscano@gmail.com','3313228655','6707E7DF0F01FBFD71B6B8237668E21D'); 

INSERT INTO Customer (customer_id, name, surname, date_birth, place_birth, sex, fiscal_code, street_name, street_number, city, zip, email, mobile_phone, password) VALUES ('49f53c0d-bbf0-48e5-87fd-e5411dd7cd9b', 'costantino', 'manfrin', '1959-05-09', 'treviso', 'male', 'MNFCTN59E09L407G', 'via udine', '14', 'padova', '35100', 'costantino.manfrin@hotmail.it', '3312378355', '314E73B336F391AA5CA0617D2814E6C1'); 

INSERT INTO Customer (customer_id, name, surname, date_birth, place_birth, sex, fiscal_code, street_name, street_number, city, zip, email, mobile_phone, password) VALUES ('ea77383f-e4f2-4268-b03e-74cf44a776d1', 'maria', 'trevisan', '1988-10-14', 'venezia', 'female', 'TRVMRA88R54L736A', 'via belzoni', '27', 'padova', '35100', 'maria.trevisan@hotmail.it', '3311234555', '1FC4FC8CB6B7A72929EF52F66FA91D27'); 

-- Customer's Card Insert
INSERT INTO Card (card_id, organization, enabled, customer) VALUES ('6697421068', 2, TRUE, '19f8c9c8-14b2-43d9-b6a5-1d07268e840e');

UPDATE Card SET current_points = 150 WHERE card_id = '6697421068' AND organization = 2;

INSERT INTO Card (card_id, organization, enabled, customer) VALUES ('9100303147', 1, TRUE, 'ed8fa2aa-a868-4cb1-9705-e9b38aa26d88');

INSERT INTO Card (card_id, organization, enabled, customer) VALUES ('APS6A96998101', 3, TRUE, '062b665f-6284-4b77-ab18-72f08445145c');

INSERT INTO Card (card_id, organization, enabled, customer) VALUES ('4661294024', 1, TRUE, '49f53c0d-bbf0-48e5-87fd-e5411dd7cd9b');

INSERT INTO Card (card_id, organization, enabled, customer) VALUES ('9731583326CN', 4, TRUE, 'ea77383f-e4f2-4268-b03e-74cf44a776d1');

INSERT INTO Card (card_id, organization, enabled, customer) VALUES ('5331654267', 2, FALSE, '19f8c9c8-14b2-43d9-b6a5-1d07268e840e');

-- Hire actions Insert
INSERT INTO Hire (card, organization, bike, docking_point_unlock, date_unlock) VALUES ('6697421068', 2, 1, 3, '2018-05-19 10:00:54+02');

UPDATE Hire SET KM_ride = 4, docking_point_lock = 7, date_lock = '2018-05-19 10:20:03+02' WHERE card = '6697421068' AND organization = 2;

INSERT INTO Hire (card, organization, bike, docking_point_unlock, date_unlock) VALUES ('9100303147', 1, 2, 8, '2018-05-20 08:22:54+02');
 
UPDATE Hire SET KM_ride = 2, docking_point_lock = 9, date_lock = '2018-05-20 08:44:50+02' WHERE card = '9100303147' AND organization = 1;

INSERT INTO Hire (card, organization, bike, docking_point_unlock, date_unlock) VALUES ('APS6A96998101', 3, 1, 4, '2018-05-26 9:14:06+02'); 
 
UPDATE Hire SET KM_ride = 1.32, docking_point_lock = 5, date_lock = '2018-05-26 9:17:00+02' WHERE card = 'APS6A96998101' AND organization = 3;

INSERT INTO Hire (card, organization, bike, docking_point_unlock, date_unlock) VALUES ('4661294024', 1, 5, 1, '2018-05-03 13:02:53+02');
 
UPDATE Hire SET KM_ride = 0.52, docking_point_lock = 8, date_lock = '2018-05-03 13:29:11+02' WHERE card = '4661294024' AND organization = 1;

INSERT INTO Hire (card, organization, bike, docking_point_unlock, date_unlock) VALUES ('APS6A96998101', 3, 3, 2, '2018-03-01 13:17:53+01');

UPDATE Hire SET KM_ride = 3, docking_point_lock = 7, date_lock = '2018-03-01 13:33:00+01' WHERE card = 'APS6A96998101' AND organization = 3;

INSERT INTO Hire (card, organization, bike, docking_point_unlock, date_unlock) VALUES ('5331654267', 2, 2, 1, '2018-5-4 12:03:53+02');

UPDATE Hire SET KM_ride = 3, docking_point_lock = 2, date_lock = '2018-5-4 12:29:11+02' WHERE card = '5331654267' AND organization = 2;





-- Card actions - check if the trigger function works correctly

INSERT INTO Card (card_id, organization, enabled, customer) VALUES ('1156896998', 3, TRUE, '062b665f-6284-4b77-ab18-72f08445145c');

INSERT INTO Customer (customer_id, name, surname, date_birth, place_birth, sex, fiscal_code, street_name, street_number, city, zip, email, mobile_phone, password) VALUES ('5ffafdd2-ea0a-45b1-a7ca-a47aa166d901', 'Antonella', 'Friso', '1995-10-14', 'padova', 'female', 'FRSNNL95R54G224A', 'via Petrarca', '32/A', 'padova', '35100', 'antonella.friso@gmail.com', '3487345776', 'f89a63dd3424e14e5c172235e2ee1634'); 

INSERT INTO Card (card_id, organization, enabled, customer) VALUES ('1456896563', 2, FALSE, '5ffafdd2-ea0a-45b1-a7ca-a47aa166d901');
