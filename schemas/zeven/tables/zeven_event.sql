-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_event
-- Type: TABLE

-- Name: zeven_event; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_event (
    zeven_eventid numeric NOT NULL,
    event_name character varying(500),
    event_date timestamp without time zone,
    is_published numeric,
    is_deleted numeric,
    registration_fee numeric,
    winning_prize character varying(200),
    event_type numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    venue_masterid numeric(10,0),
    venue_parentid numeric(10,0),
    event_desc character varying(4000),
    event_end_date timestamp without time zone,
    image_path character varying(500),
    start_time character varying(20),
    end_time character varying(20)
);


--
