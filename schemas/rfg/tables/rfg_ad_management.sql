-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_ad_management
-- Type: TABLE

-- Name: rfg_ad_management; Type: TABLE; Schema: rfg; Owner: -
--

CREATE TABLE rfg.rfg_ad_management (
    ad_id numeric NOT NULL,
    ad_type text,
    ad_code text,
    is_active numeric
);


--
