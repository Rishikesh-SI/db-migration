-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_app_status_20180514
-- Type: TABLE

-- Name: tcs_app_status_20180514; Type: TABLE; Schema: tcs; Owner: -
--

CREATE TABLE tcs.tcs_app_status_20180514 (
    app_id numeric,
    first_name character varying(100),
    last_name character varying(100),
    date_of_birth timestamp without time zone,
    gender character varying(50),
    race character varying(100),
    status character varying(100),
    reject_reason character varying(500),
    bib_no character varying(50),
    section character varying(500),
    tshirt_size character varying(200),
    race_day_info_book character varying(500),
    tshirt_type character varying(50),
    years_participated character varying(200),
    go_green character varying(10),
    created_date time with time zone,
    updated_date time without time zone,
    is_active numeric,
    is_deleted numeric
);


--
