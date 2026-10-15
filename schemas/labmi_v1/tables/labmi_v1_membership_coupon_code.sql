-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_membership_coupon_code
-- Type: TABLE

-- Name: labmi_v1_membership_coupon_code; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_membership_coupon_code (
    coupon_code_id numeric NOT NULL,
    coupon_code character varying(256),
    product_id numeric,
    user_guid character varying(500),
    is_used numeric,
    allocated_date timestamp without time zone
);


--
