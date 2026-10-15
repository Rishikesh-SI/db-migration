-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_group
-- Type: TABLE

-- Name: dhm_group; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_group (
    group_id numeric NOT NULL,
    group_name character varying(500),
    no_of_runners numeric,
    pledged_distance character varying(500),
    open10k_registrants character varying(500),
    half_marathon_registrants character varying(500),
    gdr5k_registrants character varying(500),
    open10k_registrants_overseas character varying(500),
    half_marathon_registrants_overseas character varying(500),
    gdr5k_registrants_overseas character varying(500),
    total_fees character varying(500),
    invoice_company_name character varying(500),
    invoice_address text,
    group_contact_name text,
    group_contact_email text,
    group_contact_number text,
    group_pancard_number text,
    group_pancard_name character varying(500),
    group_gst_number text,
    state_name character varying(500),
    state_id numeric,
    created_date timestamp without time zone DEFAULT now(),
    updated_date timestamp without time zone,
    corporate_type numeric
);


--
