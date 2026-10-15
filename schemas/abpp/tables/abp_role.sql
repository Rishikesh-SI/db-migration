-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_role
-- Type: TABLE

-- Name: abp_role; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_role (
    role_id numeric NOT NULL,
    role_name character varying(300) NOT NULL,
    role_display_name character varying(300) NOT NULL,
    role_desc character varying(3000),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    role_guid character varying(256) NOT NULL
);


--
