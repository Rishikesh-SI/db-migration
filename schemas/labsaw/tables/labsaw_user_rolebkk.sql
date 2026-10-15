-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_user_rolebkk
-- Type: TABLE

-- Name: labsaw_user_rolebkk; Type: TABLE; Schema: labsaw; Owner: -
--

CREATE TABLE labsaw.labsaw_user_rolebkk (
    user_role_id numeric,
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
