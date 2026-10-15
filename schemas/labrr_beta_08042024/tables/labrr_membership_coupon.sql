-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_membership_coupon
-- Type: TABLE

-- Name: labrr_membership_coupon; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_membership_coupon (
    coupon_code character varying,
    created_date timestamp without time zone,
    used boolean,
    times_used numeric,
    is_flag numeric
);


--
