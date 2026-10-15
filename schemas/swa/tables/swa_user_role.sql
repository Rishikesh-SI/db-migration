-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_user_role
-- Type: TABLE

-- Name: swa_user_role; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_user_role (
    user_role_id numeric NOT NULL,
    user_id numeric NOT NULL,
    role_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    user_role_guid character varying(256) NOT NULL
);


--
