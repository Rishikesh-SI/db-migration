-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_group
-- Type: TABLE

-- Name: upstox_group; Type: TABLE; Schema: upstox; Owner: -
--

CREATE TABLE upstox.upstox_group (
    group_id numeric NOT NULL,
    group_name character varying(500),
    no_of_runners numeric,
    pledged_distance character varying(500),
    ind_1_50km character varying(500),
    ind_51_100km character varying(500),
    ind_101_above character varying(500),
    ov_1_50km character varying(500),
    ov_51_100km character varying(500),
    ov_101_above character varying(500),
    total_fees character varying(500),
    invoice_address text,
    group_contact_name text,
    group_contact_email text,
    group_contact_number text,
    group_pancard_number text,
    group_gst_number text,
    state_name character varying(500),
    state_code character varying(500),
    no_of_participants_indian numeric,
    no_of_participants_overseas numeric,
    tier character varying(50),
    created_date timestamp without time zone DEFAULT now(),
    updated_date timestamp without time zone,
    corporate_type numeric
);


--
