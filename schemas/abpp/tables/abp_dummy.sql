-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_dummy
-- Type: TABLE

-- Name: abp_dummy; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_dummy (
    asset_id numeric,
    asset_type_id numeric,
    published_version_number numeric,
    entities jsonb
);


--
