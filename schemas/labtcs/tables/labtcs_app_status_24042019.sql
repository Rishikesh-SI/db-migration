-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_app_status_24042019
-- Type: TABLE

-- Name: labtcs_app_status_24042019; Type: TABLE; Schema: labtcs; Owner: -
--

CREATE TABLE labtcs.labtcs_app_status_24042019 (
    app_id numeric,
    first_name character varying(100),
    last_name character varying(100),
    date_of_birth date,
    gender character varying(50),
    race character varying(100),
    status character varying(100),
    reject_reason character varying(500),
    bib_no character varying(50),
    section character varying(500),
    tshirt_size character varying(50),
    race_day_info_book character varying(500),
    tshirt_type character varying(50),
    years_participated character varying(200),
    go_green character varying(10),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    jabong_voucher character varying(100),
    app_guid text,
    group_name text
);


--
