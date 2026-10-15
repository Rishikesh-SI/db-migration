-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_misscall_pledge_detail
-- Type: TABLE

-- Name: zeven_misscall_pledge_detail; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_misscall_pledge_detail (
    misscall_pledge_id numeric NOT NULL,
    misscall_pledge_sid character varying(50),
    verified_number character varying(20),
    listener_node character varying(20),
    verification_call_time character varying(50),
    service_operator character varying(50),
    telo_circle character varying(50),
    number_type character varying(50),
    dnd_status character varying(5),
    ip_address character varying(50),
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    is_active numeric,
    is_deleted numeric
);


--
