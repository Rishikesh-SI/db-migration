-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_runners_year_data
-- Type: TABLE

-- Name: tmmimg_upd_runners_year_data; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_runners_year_data (
    runners_year_data_id numeric NOT NULL,
    app_id numeric,
    first_name character varying(100),
    last_name character varying(100),
    gender character(1),
    age numeric,
    date_of_birth date,
    race character varying(100),
    bib_no numeric,
    finish_time character varying(30),
    race_status character varying(100),
    rank numeric,
    category_rank numeric,
    gender_rank numeric,
    year numeric,
    is_timefield numeric
);


--
