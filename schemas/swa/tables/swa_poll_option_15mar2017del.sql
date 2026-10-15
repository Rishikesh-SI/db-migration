-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_poll_option_15mar2017del
-- Type: TABLE

-- Name: swa_poll_option_15mar2017del; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_poll_option_15mar2017del (
    poll_option_id numeric,
    poll_id numeric,
    option character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    poll_option_guid character varying(256),
    option_order numeric
);


--
