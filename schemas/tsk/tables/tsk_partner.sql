-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_partner
-- Type: TABLE

-- Name: tsk_partner; Type: TABLE; Schema: tsk; Owner: -
--

CREATE TABLE tsk.tsk_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
