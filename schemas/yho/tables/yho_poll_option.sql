-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_poll_option
-- Type: TABLE

-- Name: yho_poll_option; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_poll_option (
    poll_option_id numeric NOT NULL,
    poll_id numeric NOT NULL,
    option character varying(300),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    poll_option_guid character varying(256) NOT NULL,
    option_order numeric NOT NULL
);


--
