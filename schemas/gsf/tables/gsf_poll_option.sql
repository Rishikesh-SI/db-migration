-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_poll_option
-- Type: TABLE

-- Name: gsf_poll_option; Type: TABLE; Schema: gsf; Owner: -
--

CREATE TABLE gsf.gsf_poll_option (
    poll_option_id numeric NOT NULL,
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
