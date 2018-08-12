SET SCHEMA "KTDB1";
-- Basic tables
CREATE ROW TABLE "geolocation::continent.t_continent"  ( 
	"id" BIGINT CS_FIXED NOT NULL,
	"code" NVARCHAR(2)  CS_STRING,
	"name" VARCHAR(255) CS_STRING,
	"enable" BOOLEAN CS_INT DEFAULT FALSE,
	PRIMARY KEY ( "id" )
);

CREATE ROW TABLE "geolocation::continent.t_country"  ( 
	"id" BIGINT CS_FIXED NOT NULL,
	"continent.id" BIGINT CS_FIXED, 
	"code" NVARCHAR(2)  CS_STRING, 
	"name" VARCHAR(255) CS_STRING, 
	"enable" BOOLEAN CS_INT DEFAULT FALSE, 
	PRIMARY KEY ( "id" )
);

CREATE ROW TABLE "geolocation::continent.t_direct_city"  ( 
	"id" BIGINT CS_FIXED NOT NULL, 
	"counntrtry.id" BIGINT CS_FIXED, 
	"name" VARCHAR(255) CS_STRING, 
	"enable" BOOLEAN CS_INT DEFAULT FALSE, 
	PRIMARY KEY ( "id" ) 
);

CREATE ROW TABLE "geolocation::continent.t_state"  (
	"id" BIGINT CS_FIXED NOT NULL,
	"country.id" BIGINT CS_FIXED,
	"name" VARCHAR(255) CS_STRING,
	"enable" BOOLEAN CS_INT DEFAULT FALSE,
	PRIMARY KEY ( "id" )
);

CREATE ROW TABLE "geolocation::continent.t_city"  (
	"id" BIGINT CS_FIXED NOT NULL,
	"state.id" BIGINT CS_FIXED,
	"name" VARCHAR(255) CS_STRING,
	"enable" BOOLEAN CS_INT DEFAULT FALSE,
	PRIMARY KEY ( "id" )
);

-- Sequence
CREATE SEQUENCE "geolocation::s_continent" 
	START WITH 10
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 999999
	RESET BY SELECT IFNULL(MAX("id"), 10) + 1 FROM "geolocation::continent.t_continent";

CREATE SEQUENCE "geolocation::s_country" 
	START WITH 10
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 999999
	RESET BY SELECT IFNULL(MAX("id"), 10) + 1 FROM "geolocation::continent.t_country";

CREATE SEQUENCE "geolocation::s_direct_city" 
	START WITH 10
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 999999
	RESET BY SELECT IFNULL(MAX("id"), 10) + 1 FROM "geolocation::continent.t_direct_city";

CREATE SEQUENCE "geolocation::s_state" 
	START WITH 10
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 999999
	RESET BY SELECT IFNULL(MAX("id"), 10) + 1 FROM "geolocation::continent.t_state";

CREATE SEQUENCE "geolocation::s_city" 
	START WITH 10
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 999999
	RESET BY SELECT IFNULL(MAX("id"), 10) + 1 FROM "geolocation::continent.t_city";

-- Default records
-- Just in case previous data still existed
-- DELETE FROM "geolocation::continent.t_continent";
-- ALTER SEQUENCE "geolocation::s_continent" RESTART WITH 10;

INSERT INTO "geolocation::continent.t_continent" ("id", "code", "name") VALUES
("geolocation::s_continent".nextval, 'AS', 'Asia');
INSERT INTO "geolocation::continent.t_continent" ("id", "code", "name") VALUES
("geolocation::s_continent".nextval, 'EU', 'Eropa');
INSERT INTO "geolocation::continent.t_continent" ("id", "code", "name") VALUES
("geolocation::s_continent".nextval, 'AF', 'Africa');
INSERT INTO "geolocation::continent.t_continent" ("id", "code", "name") VALUES
("geolocation::s_continent".nextval, 'NA', 'North America');
INSERT INTO "geolocation::continent.t_continent" ("id", "code", "name") VALUES
("geolocation::s_continent".nextval, 'SA', 'Latin America');
UPDATE "geolocation::continent.t_continent" SET "enable" = TRUE;

INSERT INTO "geolocation::continent.t_country" ("id", "continent.id", "code", "name")
SELECT "geolocation::s_country".nextval, t_continent."id", 'DE', 'Germany'
FROM "geolocation::continent.t_continent" t_continent
WHERE t_continent."code" = 'EU';

INSERT INTO "geolocation::continent.t_country" ("id", "continent.id", "code", "name")
SELECT "geolocation::s_country".nextval, t_continent."id", 'FR', 'France'
FROM "geolocation::continent.t_continent" t_continent
WHERE t_continent."code" = 'EU';

INSERT INTO "geolocation::continent.t_country" ("id", "continent.id", "code", "name")
SELECT "geolocation::s_country".nextval, t_continent."id", 'GB', 'United Kingdom'
FROM "geolocation::continent.t_continent" t_continent
WHERE t_continent."code" = 'EU';

INSERT INTO "geolocation::continent.t_country" ("id", "continent.id", "code", "name")
SELECT "geolocation::s_country".nextval, t_continent."id", 'MY', 'Malaysia'
FROM "geolocation::continent.t_continent" t_continent
WHERE t_continent."code" = 'AS';

INSERT INTO "geolocation::continent.t_country" ("id", "continent.id", "code", "name")
SELECT "geolocation::s_country".nextval, t_continent."id", 'PH', 'Philippines'
FROM "geolocation::continent.t_continent" t_continent
WHERE t_continent."code" = 'AS';


