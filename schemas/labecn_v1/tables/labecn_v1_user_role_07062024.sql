-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1
-- Object: labecn_v1_user_role_07062024
-- Type: TABLE

-- Name: labecn_v1_user_role_07062024; Type: TABLE; Schema: labecn_v1; Owner: -
--

CREATE TABLE labecn_v1.labecn_v1_user_role_07062024 (
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
