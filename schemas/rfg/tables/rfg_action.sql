-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_action
-- Type: TABLE

-- Name: rfg_action; Type: TABLE; Schema: rfg; Owner: -
--

CREATE TABLE rfg.rfg_action (
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
