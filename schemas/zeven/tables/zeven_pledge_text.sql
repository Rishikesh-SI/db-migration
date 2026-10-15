-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_pledge_text
-- Type: TABLE

-- Name: zeven_pledge_text; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_pledge_text (
    pledge_text_id numeric NOT NULL,
    pledge_text character varying(1000),
    ip_address character varying(50),
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    is_active numeric,
    is_deleted numeric,
    mobile_no character varying(20),
    reference_no numeric
);


--
