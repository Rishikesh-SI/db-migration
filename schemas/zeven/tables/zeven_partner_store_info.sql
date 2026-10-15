-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_partner_store_info
-- Type: TABLE

-- Name: zeven_partner_store_info; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_partner_store_info (
    zvn_partner_store_info_id numeric NOT NULL,
    store_name character varying(100),
    store_address character varying(4000),
    contact_person character varying(100),
    contact_number text,
    city character varying(100),
    state character varying(100),
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    is_active numeric,
    is_deleted numeric,
    link character varying(4000),
    embedded_link character varying(4000)
);


--
