-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_user_role
-- Type: TABLE

-- Name: labpbl_user_role; Type: TABLE; Schema: labpbl; Owner: -
--

CREATE TABLE labpbl.labpbl_user_role (
    user_role_id numeric NOT NULL,
    user_id numeric,
    role_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    user_role_guid character varying(256)
);


--
