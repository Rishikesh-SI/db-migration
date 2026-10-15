-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_template_styles
-- Type: TABLE

-- Name: zeven_template_styles; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_template_styles (
    id numeric NOT NULL,
    template character varying(50) NOT NULL,
    client_id numeric NOT NULL,
    home character varying(7) NOT NULL,
    title character varying(255) NOT NULL,
    params text,
    si_client_id numeric
);


--
