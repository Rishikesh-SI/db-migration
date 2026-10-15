-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_admin_user
-- Type: TABLE

-- Name: gpn_admin_user; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_admin_user (
    admin_user_id numeric NOT NULL,
    client_id numeric NOT NULL,
    user_name character varying(300) NOT NULL,
    full_name character varying(300) NOT NULL,
    display_name character varying(300) NOT NULL,
    user_password character varying(256) NOT NULL,
    reset_key character varying(256),
    key_expiry_date timestamp without time zone,
    failed_attempts numeric,
    unlock_date timestamp without time zone,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
