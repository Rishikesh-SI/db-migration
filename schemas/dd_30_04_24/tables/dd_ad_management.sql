-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_ad_management
-- Type: TABLE

-- Name: dd_ad_management; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_ad_management (
    ad_id numeric NOT NULL,
    ad_type text,
    ad_code text,
    is_active numeric
);


--
