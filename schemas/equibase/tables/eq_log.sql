-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: equibase
-- Object: eq_log
-- Type: TABLE

-- Name: eq_log; Type: TABLE; Schema: equibase; Owner: -
--

CREATE TABLE equibase.eq_log (
    logid numeric(20,0) NOT NULL,
    eq_user_masterid numeric(20,0),
    object_type character varying(500),
    object_name character varying(1000),
    error_code numeric(20,0),
    error_msg character varying(4000),
    str1 character varying(4000),
    str2 character varying(4000),
    num1 numeric(38,4),
    num2 numeric(38,4),
    created_date timestamp without time zone DEFAULT (now())::timestamp without time zone
);


--
