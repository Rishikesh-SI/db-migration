-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_process_tab
-- Type: TABLE

-- Name: gpn_process_tab; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_process_tab (
    user_id numeric,
    application_id numeric,
    device_token character varying(500),
    device_id character varying(500),
    period text,
    status integer,
    call_json jsonb
);


--
