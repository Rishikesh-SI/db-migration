-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_role
-- Type: TABLE

-- Name: labfg_role; Type: TABLE; Schema: labfg; Owner: -
--

CREATE TABLE labfg.labfg_role (
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
    role_guid character varying(256)
);


--
