-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_guest_login_user_map
-- Type: TABLE

-- Name: labyho_guest_login_user_map; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_guest_login_user_map (
    guest_guid character varying(500),
    user_guid character varying(500),
    user_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
