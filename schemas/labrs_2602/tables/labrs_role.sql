-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: labrs_role
-- Type: TABLE

-- Name: labrs_role; Type: TABLE; Schema: labrs_2602; Owner: -
--

CREATE TABLE labrs_2602.labrs_role (
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
