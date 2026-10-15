-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_ad_management
-- Type: TABLE

-- Name: upy_ad_management; Type: TABLE; Schema: upy; Owner: -
--

CREATE TABLE upy.upy_ad_management (
    ad_id numeric NOT NULL,
    ad_type text,
    ad_code text,
    is_active numeric
);


--
