-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_skill_master
-- Type: TABLE

-- Name: ss_skill_master; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_skill_master (
    cf_skillid numeric(25,0) NOT NULL,
    skill_name character varying(255),
    is_active numeric(1,0) NOT NULL,
    is_deleted numeric(1,0) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
