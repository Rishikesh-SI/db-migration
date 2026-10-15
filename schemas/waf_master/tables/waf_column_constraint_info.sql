-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_column_constraint_info
-- Type: TABLE

-- Name: waf_column_constraint_info; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_column_constraint_info (
    table_name character varying,
    table_schema character varying,
    column_name character varying,
    constraint_name character varying,
    status character varying
);


--
