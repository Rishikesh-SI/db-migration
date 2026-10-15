-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_gratification_gift
-- Type: TABLE

-- Name: labmao_gratification_gift; Type: TABLE; Schema: labmao; Owner: -
--

CREATE TABLE labmao.labmao_gratification_gift (
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
