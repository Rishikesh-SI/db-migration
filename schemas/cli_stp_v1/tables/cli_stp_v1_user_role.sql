-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_user_role
-- Type: TABLE

-- Name: cli_stp_v1_user_role; Type: TABLE; Schema: cli_stp_v1; Owner: -
--

CREATE TABLE cli_stp_v1.cli_stp_v1_user_role (
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
