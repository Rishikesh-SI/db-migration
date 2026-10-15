-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: elms
-- Object: elms_ad_management
-- Type: TABLE

-- Name: elms_ad_management; Type: TABLE; Schema: elms; Owner: -
--

CREATE TABLE elms.elms_ad_management (
    ad_id numeric NOT NULL,
    ad_type text,
    ad_code text,
    is_active numeric
);


--
