-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_user_language_map
-- Type: TABLE

-- Name: upp_user_language_map; Type: TABLE; Schema: upp; Owner: -
--

CREATE TABLE upp.upp_user_language_map (
    user_language_map_id numeric NOT NULL,
    user_id numeric NOT NULL,
    language_master_id numeric NOT NULL,
    user_name character varying(300) NOT NULL,
    full_name character varying(300) NOT NULL,
    display_name character varying(300) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    bio text
);


--
