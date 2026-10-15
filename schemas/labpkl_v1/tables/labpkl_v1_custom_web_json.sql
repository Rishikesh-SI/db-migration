-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_custom_web_json
-- Type: TABLE

-- Name: labpkl_v1_custom_web_json; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.labpkl_v1_custom_web_json (
    custom_id numeric NOT NULL,
    module_name character varying,
    match_day character varying,
    data_json jsonb
);


--
