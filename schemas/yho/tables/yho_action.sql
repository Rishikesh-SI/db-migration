-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_action
-- Type: TABLE

-- Name: yho_action; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_action (
    action_id numeric NOT NULL,
    action_name character varying(300) NOT NULL,
    action_display_name character varying(300) NOT NULL,
    action_desc character varying(3000),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    action_guid character varying(256) NOT NULL
);


--
