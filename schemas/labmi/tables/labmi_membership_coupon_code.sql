-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_membership_coupon_code
-- Type: TABLE

-- Name: labmi_membership_coupon_code; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_membership_coupon_code (
    coupon_code_id numeric NOT NULL,
    coupon_code character varying(256),
    product_id numeric,
    user_guid character varying(500),
    is_used numeric,
    allocated_date timestamp without time zone
);


--
