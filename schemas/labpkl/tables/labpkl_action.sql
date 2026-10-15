-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_action
-- Type: TABLE

-- Name: labpkl_action; Type: TABLE; Schema: labpkl; Owner: -
--

CREATE TABLE labpkl.labpkl_action (
    action_id numeric NOT NULL,
    action_name character varying(300),
    action_display_name character varying(300),
    action_desc character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    action_guid character varying(256)
);


--
