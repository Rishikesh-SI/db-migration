-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_membership_coupon_15012024
-- Type: TABLE

-- Name: labrr_membership_coupon_15012024; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_membership_coupon_15012024 (
    coupon_code character varying,
    created_date timestamp without time zone,
    used character varying,
    times_used numeric,
    is_flag numeric
);


--
