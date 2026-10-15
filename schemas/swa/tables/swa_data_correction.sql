-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_data_correction
-- Type: TABLE

-- Name: swa_data_correction; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_data_correction (
    asset_type_id numeric,
    asset_id numeric,
    version_number numeric,
    title character varying(4000),
    title_alias character varying(4000),
    slug_url text
);


--
