-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_platform
-- Type: TABLE

-- Name: gpn_platform; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_platform (
    platform_id numeric NOT NULL,
    platform_name character varying(50) NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
