-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: color_type
-- Type: TYPE

-- Name: color_type; Type: TYPE; Schema: lb_wf; Owner: -
--

CREATE TYPE lb_wf.color_type AS (
	name character varying,
	code character varying,
	hex_value character varying
);


--
