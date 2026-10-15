-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_user_preferences
-- Type: TABLE

-- Name: labdms_user_preferences; Type: TABLE; Schema: labdms; Owner: -
--

CREATE TABLE labdms.labdms_user_preferences (
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
