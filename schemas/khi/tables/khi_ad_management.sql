-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_ad_management
-- Type: TABLE

-- Name: khi_ad_management; Type: TABLE; Schema: khi; Owner: -
--

CREATE TABLE khi.khi_ad_management (
    ad_id numeric NOT NULL,
    ad_type text,
    ad_code text,
    is_active numeric
);


--
