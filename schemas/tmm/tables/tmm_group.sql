-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_group
-- Type: TABLE

-- Name: tmm_group; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_group (
    group_id numeric NOT NULL,
    group_name character varying(500),
    no_of_runners numeric,
    pledged_distance character varying(500),
    marathon_registrants character varying(500),
    open10k_registrants character varying(500),
    half_marathon_registrants character varying(500),
    open5k_registrants character varying(500),
    open2p5k_registrants character varying(500),
    marathon_registrants_overseas character varying(500),
    open10k_registrants_overseas character varying(500),
    half_marathon_registrants_overseas character varying(500),
    open5k_registrants_overseas character varying(500),
    open2p5k_registrants_overseas character varying(500),
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
    corporate_type numeric,
    participation_format character varying(500),
    chosen_distance character varying(50),
    dreamrun_registrants character varying,
    dreamrun_registrants_overseas character varying
);


--
