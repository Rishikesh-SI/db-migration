-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_ing_bib_detail
-- Type: TABLE

-- Name: labtcs_ing_bib_detail; Type: TABLE; Schema: labtcs; Owner: -
--

CREATE TABLE labtcs.labtcs_ing_bib_detail (
    ing_bib_detail_id numeric NOT NULL,
    transaction_id character varying(1000),
    first_name character varying(500),
    last_name character varying(500),
    date_of_birth timestamp without time zone,
    is_active numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
