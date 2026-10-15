-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: colors
-- Type: TABLE

-- Name: colors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.colors (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    hex_value character varying(7) NOT NULL
);


--
