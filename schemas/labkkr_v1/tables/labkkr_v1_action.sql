-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_action
-- Type: TABLE

-- Name: labkkr_v1_action; Type: TABLE; Schema: labkkr_v1; Owner: -
--

CREATE TABLE labkkr_v1.labkkr_v1_action (
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
