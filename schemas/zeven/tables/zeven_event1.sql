-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_event1
-- Type: TABLE

-- Name: zeven_event1; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_event1 (
    "ZEVEN_EVENTID" numeric NOT NULL,
    "EVENT_NAME" character varying(500),
    "EVENT_DATE" timestamp without time zone,
    "IS_PUBLISHED" numeric,
    "IS_DELETED" numeric,
    "REGISTRATION_FEE" numeric,
    "WINNING_PRIZE" character varying(200),
    "EVENT_TYPE" numeric,
    "CREATED_DATE" timestamp without time zone,
    "UPDATED_DATE" timestamp without time zone,
    "VENUE_MASTERID" numeric(10,0),
    "VENUE_PARENTID" numeric(10,0),
    "EVENT_DESC" character varying(4000),
    "EVENT_END_DATE" timestamp without time zone,
    "IMAGE_PATH" character varying(500),
    "START_TIME" character varying(20),
    "END_TIME" character varying(20)
);


--
