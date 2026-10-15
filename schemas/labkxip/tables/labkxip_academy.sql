-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_academy
-- Type: TABLE

-- Name: labkxip_academy; Type: TABLE; Schema: labkxip; Owner: -
--

CREATE TABLE labkxip.labkxip_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
