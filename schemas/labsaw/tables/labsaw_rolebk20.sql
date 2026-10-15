-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_rolebk20
-- Type: TABLE

-- Name: labsaw_rolebk20; Type: TABLE; Schema: labsaw; Owner: -
--

CREATE TABLE labsaw.labsaw_rolebk20 (
    role_id numeric,
    role_name character varying(300),
    role_display_name character varying(300),
    role_desc character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    role_guid character varying(256),
    role_json jsonb,
    is_super_admin numeric
);


--
