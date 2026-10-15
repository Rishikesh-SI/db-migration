-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_sport_master
-- Type: TABLE

-- Name: zeven_sport_master; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_sport_master (
    sport_master_id numeric NOT NULL,
    sport_name character varying(100) NOT NULL,
    created_date timestamp(6) without time zone NOT NULL,
    update_date timestamp(6) without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_delete numeric NOT NULL,
    si_client_id numeric NOT NULL
);


--
