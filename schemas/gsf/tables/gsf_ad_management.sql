-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_ad_management
-- Type: TABLE

-- Name: gsf_ad_management; Type: TABLE; Schema: gsf; Owner: -
--

CREATE TABLE gsf.gsf_ad_management (
    ad_id numeric NOT NULL,
    ad_type text,
    ad_code text,
    is_active numeric
);


--
