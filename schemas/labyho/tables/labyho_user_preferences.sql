-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_user_preferences
-- Type: TABLE

-- Name: labyho_user_preferences; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_user_preferences (
    user_id numeric,
    user_guid character varying(500),
    guest_guid character varying(500),
    type_id numeric,
    type_name character varying(50),
    value numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
