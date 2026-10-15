-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_custom_user
-- Type: TABLE

-- Name: zeven_custom_user; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_custom_user (
    zeven_custom_user_id numeric NOT NULL,
    full_name character varying(256) NOT NULL,
    email_id character varying(256) NOT NULL,
    password character varying(256) NOT NULL,
    is_active numeric(1,0),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
