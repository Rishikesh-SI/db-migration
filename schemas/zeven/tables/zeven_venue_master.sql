-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_venue_master
-- Type: TABLE

-- Name: zeven_venue_master; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_venue_master (
    venue_masterid numeric NOT NULL,
    venue_name character varying(500) NOT NULL,
    shortname character varying(250),
    display_name character varying(1000),
    known_as character varying(500),
    venue_type integer NOT NULL,
    venue_parentid numeric,
    email_id character varying(256),
    city_id numeric,
    state_id numeric,
    country_id numeric,
    pincode numeric(20,0),
    description character varying(2000),
    sport_master_id numeric,
    capacity numeric,
    dress_code character varying(100),
    price character varying(500),
    mobile_no character varying(500),
    mobile_no1 character varying(500),
    telephone_no character varying(500),
    timings character varying(500),
    is_active numeric,
    created_date timestamp(0) without time zone DEFAULT now(),
    updated_date timestamp(0) without time zone DEFAULT now(),
    is_featured numeric,
    address character varying(1000),
    event character varying(48),
    longitude numeric(15,8),
    latitude numeric(15,6),
    google_map character varying(100),
    zone_id numeric,
    is_verified numeric,
    short_address character varying(500)
);


--
