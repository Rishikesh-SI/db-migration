-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_gratification_gift
-- Type: TABLE

-- Name: isl_gratification_gift; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_gratification_gift (
    gift_id numeric,
    gift_name character varying(500),
    gift_url text,
    allocated_quantity numeric,
    available_quantity numeric,
    is_active numeric,
    is_deleted numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_flag numeric,
    remaining_quantity numeric,
    club_id numeric
);


--
