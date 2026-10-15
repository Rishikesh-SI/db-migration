-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: labukk_gratification_gift
-- Type: TABLE

-- Name: labukk_gratification_gift; Type: TABLE; Schema: labukk; Owner: -
--

CREATE TABLE labukk.labukk_gratification_gift (
    gift_id numeric NOT NULL,
    gift_name character varying(500),
    gift_url text,
    allocated_quantity numeric,
    available_quantity numeric,
    is_active numeric,
    is_deleted numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_flag numeric
);


--
