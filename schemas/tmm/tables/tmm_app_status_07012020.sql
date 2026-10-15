-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_app_status_07012020
-- Type: TABLE

-- Name: tmm_app_status_07012020; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_app_status_07012020 (
    app_id numeric,
    first_name character varying(100),
    last_name character varying(100),
    date_of_birth date,
    gender character varying(50),
    race character varying(100),
    status character varying(100),
    reject_reason text,
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
    app_guid character varying(500)
);


--
