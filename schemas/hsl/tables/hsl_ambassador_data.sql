-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_ambassador_data
-- Type: TABLE

-- Name: hsl_ambassador_data; Type: TABLE; Schema: hsl; Owner: -
--

CREATE TABLE hsl.hsl_ambassador_data (
    ambassador_data_id numeric NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    date_of_birth timestamp without time zone,
    address character varying(4000),
    contact_no character varying(20),
    gender character varying(10),
    facebook_link character varying(2000),
    institute_name character varying(2000),
    ambassador_json jsonb,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    email_id character varying(1000)
);


--
