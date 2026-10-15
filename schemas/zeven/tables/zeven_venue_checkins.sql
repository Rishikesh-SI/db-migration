-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_venue_checkins
-- Type: TABLE

-- Name: zeven_venue_checkins; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_venue_checkins (
    zeven_venue_checkinsid numeric NOT NULL,
    user_id numeric NOT NULL,
    venue_masterid numeric NOT NULL,
    venue_parentid numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
