-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_ad_management
-- Type: TABLE

-- Name: dd_ad_management; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_ad_management (
    ad_id numeric NOT NULL,
    ad_type text,
    ad_code text,
    is_active numeric
);


--
