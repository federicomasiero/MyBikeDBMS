-- Schema Creation
CREATE SCHEMA mbt;

-- Creation of new data types
CREATE TYPE SEX AS ENUM ('male', 'female', 'other');
CREATE TYPE SUB_TYPE AS ENUM ('daily', 'hourly');
CREATE TYPE BIKE_STATUS AS ENUM ('ok', 'in maintenance', 'to be replaced', 'stolen');
CREATE TYPE BIKE_MODEL AS ENUM ('typical', 'electric');
CREATE TYPE DP_STATUS AS ENUM ('enabled', 'in maintenance', 'disabled');

-- Table Creation
-- Customer
CREATE TABLE mbt.Customer (
	customer_id UUID PRIMARY KEY,
	name TEXT NOT NULL,
	surname TEXT NOT NULL,
	street_name TEXT NOT NULL,
	street_number VARCHAR(8) NOT NULL,
	city TEXT NOT NULL,
	zip CHAR(5) NOT NULL,
	date_birth DATE NOT NULL CHECK (date_part('year', age(date_birth)) >= 16),
	place_birth TEXT NOT NULL,
	sex SEX NOT NULL,
	fiscal_code CHAR(16) NOT NULL,
	email TEXT NOT NULL UNIQUE,
	fixed_phone TEXT,
	mobile_phone TEXT,
	fax TEXT,
	password CHAR(32) NOT NULL,
	registration_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Station Manager
CREATE TABLE mbt.StationManager (
	station_manager_id UUID PRIMARY KEY,
	name TEXT NOT NULL,
	surname TEXT NOT NULL,
	street_name TEXT NOT NULL,
	street_number VARCHAR(8) NOT NULL,
	city TEXT NOT NULL,
	zip CHAR(5) NOT NULL,
	date_birth DATE NOT NULL,
	place_birth TEXT NOT NULL,
	sex SEX NOT NULL,
	fiscal_code CHAR(16) NOT NULL,
	email TEXT NOT NULL UNIQUE,
	fixed_phone TEXT,
	mobile_phone TEXT,
	fax TEXT,
	password CHAR(32) NOT NULL,
	registration_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Administrator
CREATE TABLE mbt.Administrator (
	administrator_id UUID PRIMARY KEY,
	name TEXT NOT NULL,
	surname TEXT NOT NULL,
	street_name TEXT NOT NULL,
	street_number VARCHAR(8) NOT NULL,
	city TEXT NOT NULL,
	zip CHAR(5) NOT NULL,
	date_birth DATE NOT NULL,
	place_birth TEXT NOT NULL,
	sex SEX NOT NULL,
	fiscal_code CHAR(16) NOT NULL,
	email TEXT NOT NULL UNIQUE,
	fixed_phone TEXT,
	mobile_phone TEXT,
	fax TEXT,
	password CHAR(32) NOT NULL,
	registration_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Organization
CREATE TABLE mbt.Organization (
	org_code BIGSERIAL PRIMARY KEY,
	org_name TEXT NOT NULL
);

-- Card
CREATE TABLE mbt.Card (
	card_id TEXT NOT NULL,
	organization INTEGER NOT NULL REFERENCES mbt.Organization (org_code) ON UPDATE CASCADE ON DELETE RESTRICT,
	current_credit MONEY NOT NULL DEFAULT 0 CHECK (current_credit::numeric::float8 >= 0),
	current_points INTEGER NOT NULL DEFAULT 0 CHECK (current_points >= 0),
	enabled BOOLEAN NOT NULL DEFAULT FALSE,
	customer UUID NOT NULL REFERENCES mbt.Customer (customer_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	PRIMARY KEY (card_id, organization)
);

-- Subscription
CREATE TABLE mbt.Subscription (
	subscription_code BIGSERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	price MONEY NOT NULL  CHECK (price::numeric::float8 >= 0),
	type SUB_TYPE NOT NULL,
	days_duration INTEGER,
	hours_duration INTEGER,
	CONSTRAINT DurationConst CHECK ((days_duration IS NULL AND hours_duration IS NOT NULL) OR (days_duration IS NOT NULL AND hours_duration IS NULL))
);

-- Subscription Action
CREATE TABLE mbt.SubscriptionAction (
	action_id BIGSERIAL PRIMARY KEY,
	expire_date TIMESTAMP WITH TIME ZONE NOT NULL,
	insurance BOOLEAN NOT NULL DEFAULT FALSE,
	subscription INTEGER NOT NULL REFERENCES mbt.Subscription (subscription_code) ON UPDATE RESTRICT ON DELETE RESTRICT,
	card TEXT NOT NULL,
	organization INTEGER NOT NULL,
	FOREIGN KEY (card, organization) REFERENCES mbt.Card (card_id, organization) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Shop
CREATE TABLE mbt.Shop (
	VAT_number VARCHAR(15) PRIMARY KEY,
	name TEXT NOT NULL,
	street_name TEXT NOT NULL,
	street_number VARCHAR(8) NOT NULL,
	city TEXT NOT NULL,
	zip CHAR(5) NOT NULL,
	description TEXT NOT NULL
);

-- Payment Method
CREATE TABLE mbt.PaymentMethod (
	method_code BIGSERIAL PRIMARY KEY,
	method_name TEXT NOT NULL
);

-- Charge
CREATE TABLE mbt.Charge (
	transaction_id UUID PRIMARY KEY,
	date TIMESTAMP WITH TIME ZONE NOT NULL,
	payment_method INTEGER NOT NULL REFERENCES mbt.PaymentMethod (method_code) ON UPDATE RESTRICT ON DELETE RESTRICT
);

-- Offer
CREATE TABLE mbt.Offer (
	offer_id BIGSERIAL PRIMARY KEY,
	reward_costs INTEGER NOT NULL,
	description TEXT NOT NULL,
	shop TEXT NOT NULL REFERENCES mbt.Shop (VAT_number) ON UPDATE CASCADE ON DELETE SET NULL
);

-- Bike
CREATE TABLE mbt.Bike (
	bike_id BIGSERIAL PRIMARY KEY,
	last_service date,
	status BIKE_STATUS NOT NULL,
	model BIKE_MODEL NOT NULL
);

-- Docking Station
CREATE TABLE mbt.DockingStation (
	docking_station_id BIGSERIAL PRIMARY KEY,
	station_name TEXT NOT NULL,
	latitude FLOAT NOT NULL,
	longitude FLOAT NOT NULL,
	columns_number INTEGER NOT NULL
);

-- Docking Point
CREATE TABLE mbt.DockingPoint (
	docking_point_id BIGSERIAL PRIMARY KEY,
	status DP_STATUS NOT NULL,
	docking_station INTEGER NOT NULL REFERENCES mbt.DockingStation (docking_station_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Hire
CREATE TABLE mbt.Hire (
	hire_id BIGSERIAL PRIMARY KEY,
	KM_ride FLOAT,
	card TEXT NOT NULL,
	organization INTEGER NOT NULL,
	FOREIGN KEY (card, organization) REFERENCES mbt.Card (card_id, organization) ON UPDATE CASCADE ON DELETE RESTRICT,
	bike INTEGER NOT NULL REFERENCES mbt.Bike (bike_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	docking_point_unlock INTEGER NOT NULL REFERENCES mbt.DockingPoint (docking_point_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	date_unlock TIMESTAMP WITH TIME ZONE NOT NULL,
	docking_point_lock INTEGER REFERENCES mbt.DockingPoint (docking_point_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	date_lock TIMESTAMP WITH TIME ZONE
);

-- Points Action
CREATE TABLE mbt.PointsAction (
	action_id BIGSERIAL PRIMARY KEY,
	value INTEGER NOT NULL,
	card TEXT NOT NULL,
	organization INTEGER NOT NULL,
	FOREIGN KEY (card, organization) REFERENCES mbt.Card (card_id, organization) ON UPDATE CASCADE ON DELETE RESTRICT,
	offer INTEGER REFERENCES mbt.Offer (offer_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	hire INTEGER REFERENCES mbt.Hire (hire_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	CONSTRAINT PointsConst CHECK ((offer IS NULL AND hire IS NOT NULL) OR (offer IS NOT NULL AND hire IS NULL))
);

-- Credit Action
CREATE TABLE mbt.CreditAction (
	action_id BIGSERIAL PRIMARY KEY,
	value MONEY NOT NULL,
	card TEXT NOT NULL,
	organization INTEGER NOT NULL,
	FOREIGN KEY (card, organization) REFERENCES mbt.Card (card_id, organization),
	charge UUID REFERENCES mbt.Charge (transaction_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	hire INTEGER REFERENCES mbt.Hire (hire_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	CONSTRAINT CrediConst CHECK ((charge IS NULL AND hire IS NOT NULL) OR (charge IS NOT NULL AND hire IS NULL))
);

-- Booking Action
CREATE TABLE mbt.BookingAction (
	action_id BIGSERIAL PRIMARY KEY,
	date TIMESTAMP WITH TIME ZONE NOT NULL,
	card TEXT NOT NULL,
	organization INTEGER NOT NULL,
	FOREIGN KEY (card, organization) REFERENCES mbt.Card (card_id, organization) ON UPDATE CASCADE ON DELETE RESTRICT,
	bike INTEGER REFERENCES mbt.Bike (bike_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	docking_point INTEGER REFERENCES mbt.DockingPoint (docking_point_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	CONSTRAINT AtLeastSomethingBooked CHECK (NOT(bike IS NULL AND docking_point IS NULL))
);

-- Instruction
CREATE TABLE mbt.Instruction (
	instruction_id BIGSERIAL PRIMARY KEY,
	date TIMESTAMP WITH TIME ZONE NOT NULL,
	notes TEXT,
	completed BOOLEAN NOT NULL DEFAULT FALSE,
	docking_station INTEGER NOT NULL REFERENCES mbt.DockingStation (docking_station_id) ON UPDATE CASCADE ON DELETE CASCADE,
	station_manager UUID NOT NULL REFERENCES mbt.StationManager (station_manager_id) ON UPDATE CASCADE ON DELETE CASCADE,
	administrator UUID NOT NULL REFERENCES mbt.Administrator (administrator_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Service Action
CREATE TABLE mbt.ServiceAction (
	action_id BIGSERIAL PRIMARY KEY,
	date DATE NOT NULL,
	notes TEXT,
	bike INTEGER NOT NULL REFERENCES mbt.Bike (bike_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	administrator UUID NOT NULL REFERENCES mbt.Administrator (administrator_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Scoring Action
CREATE TABLE mbt.ScoringAction (
	action_id BIGSERIAL PRIMARY KEY,
	date TIMESTAMP WITH TIME ZONE NOT NULL,
	score INTEGER NOT NULL CHECK (score >= 1 AND score <= 5),
	docking_station INTEGER NOT NULL REFERENCES mbt.DockingStation (docking_station_id) ON UPDATE CASCADE ON DELETE CASCADE,
	customer UUID NOT NULL REFERENCES mbt.Customer (customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Favourites
CREATE TABLE mbt.Favourites (
	customer UUID REFERENCES mbt.Customer (customer_id) ON UPDATE CASCADE ON DELETE CASCADE,
	docking_station INTEGER NOT NULL REFERENCES mbt.DockingStation (docking_station_id) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (customer, docking_station)
);