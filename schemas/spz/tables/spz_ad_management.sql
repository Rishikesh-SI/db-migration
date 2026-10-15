-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_ad_management
-- Type: TABLE

-- Name: spz_ad_management; Type: TABLE; Schema: spz; Owner: -
--

CREATE TABLE spz.spz_ad_management (
    ad_id numeric NOT NULL,
    ad_type text,
    ad_code text,
    is_active numeric
);


--
