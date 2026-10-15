-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_ad_management
-- Type: TABLE

-- Name: swa_ad_management; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_ad_management (
    ad_id numeric NOT NULL,
    ad_type text,
    ad_code text,
    is_active numeric
);


--
