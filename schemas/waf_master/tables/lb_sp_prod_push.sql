-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: lb_sp_prod_push
-- Type: TABLE

-- Name: lb_sp_prod_push; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.lb_sp_prod_push (
    sp_id numeric NOT NULL,
    sp_name character varying(256),
    created_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    module text
);


--
