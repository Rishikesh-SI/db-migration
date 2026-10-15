-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_journey_activity
-- Type: TABLE

-- Name: labbsc_journey_activity; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_journey_activity (
    activity_id numeric NOT NULL,
    activity_name character varying(100),
    title character varying(100),
    description text,
    image_url text,
    fee numeric,
    taxable_amount numeric,
    tax_rate character varying(50),
    igst character varying(50),
    cgst character varying(50),
    sgst character varying(50),
    product_display_name character varying(500),
    igst_amount character varying(50),
    cgst_amount character varying(50),
    sgst_amount character varying(50),
    sac_code numeric,
    merchant_name character varying(50),
    discount_amount numeric(10,2),
    base_amount numeric
);


--
