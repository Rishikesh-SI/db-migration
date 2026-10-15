-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_role
-- Type: TABLE

-- Name: labuww_role; Type: TABLE; Schema: labuww; Owner: -
--

CREATE TABLE labuww.labuww_role (
    role_id numeric NOT NULL,
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
    is_super_admin numeric,
    is_lb numeric
);


--
