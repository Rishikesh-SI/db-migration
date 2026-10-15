-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_bib_surrender
-- Type: TABLE

-- Name: tmmimg_upd_bib_surrender; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_bib_surrender (
    bib_surrender_id numeric NOT NULL,
    app_id numeric NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    date_of_birth character varying,
    gender character varying(10),
    race character varying(100),
    surrender_reason character varying(500),
    bib_no numeric,
    is_nominating character varying(3),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
