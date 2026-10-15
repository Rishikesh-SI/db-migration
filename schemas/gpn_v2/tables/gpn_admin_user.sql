-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_admin_user
-- Type: TABLE

-- Name: gpn_admin_user; Type: TABLE; Schema: gpn_v2; Owner: -
--

CREATE TABLE gpn_v2.gpn_admin_user (
    admin_user_id numeric NOT NULL,
    client_id numeric,
    user_name character varying(500),
    full_name character varying(500),
    display_name character varying(500),
    user_password character varying,
    user_guid character varying(500),
    status numeric,
    failed_attempts numeric,
    unlock_date timestamp without time zone,
    reset_key character varying(500),
    key_expiry_date timestamp without time zone,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
