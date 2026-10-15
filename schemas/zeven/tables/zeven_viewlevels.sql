-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_viewlevels
-- Type: TABLE

-- Name: zeven_viewlevels; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_viewlevels (
    id numeric NOT NULL,
    title character varying(100) NOT NULL,
    ordering numeric NOT NULL,
    rules text NOT NULL,
    si_client_id numeric
);


--
