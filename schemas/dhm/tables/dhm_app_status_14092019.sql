-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_app_status_14092019
-- Type: TABLE

-- Name: dhm_app_status_14092019; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_app_status_14092019 (
    app_id numeric,
    first_name character varying(100),
    last_name character varying(100),
    date_of_birth date,
    gender character varying(50),
    race character varying(100),
    status character varying(100),
    reject_reason character varying(4000),
    bib_no character varying(50),
    section character varying(500),
    tshirt_size character varying(50),
    race_day_info_book character varying(500),
    tshirt_type character varying(50),
    years_participated character varying(200),
    go_green character varying(10),
    created_date time with time zone,
    updated_date time without time zone,
    is_active numeric,
    is_deleted numeric,
    jabong_voucher character varying(100)
);


--
