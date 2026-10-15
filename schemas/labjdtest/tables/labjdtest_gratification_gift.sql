-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_gratification_gift
-- Type: TABLE

-- Name: labjdtest_gratification_gift; Type: TABLE; Schema: labjdtest; Owner: -
--

CREATE TABLE labjdtest.labjdtest_gratification_gift (
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
