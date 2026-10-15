-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_user_journal
-- Type: TABLE

-- Name: zeven_user_journal; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_user_journal (
    journal_id numeric NOT NULL,
    user_id numeric,
    sport_id numeric,
    duration character varying(20),
    venue_name character varying(200),
    journal_date timestamp(0) without time zone,
    note character varying(200),
    created_date timestamp(6) without time zone,
    updated_date timestamp(6) without time zone,
    is_delete numeric,
    venue_id numeric
);


--
