-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_assets
-- Type: TABLE

-- Name: zeven_assets; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_assets (
    id numeric NOT NULL,
    parent_id numeric NOT NULL,
    lft numeric NOT NULL,
    rgt numeric NOT NULL,
    level_ numeric NOT NULL,
    name character varying NOT NULL,
    title character varying(100) NOT NULL,
    rules text NOT NULL,
    si_client_id numeric
);


--
