-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_code_master
-- Type: TABLE

-- Name: abp_code_master; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_code_master (
    cm_id numeric,
    db_obj_type character varying(5),
    db_obj_name character varying(100),
    db_obj_code text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
