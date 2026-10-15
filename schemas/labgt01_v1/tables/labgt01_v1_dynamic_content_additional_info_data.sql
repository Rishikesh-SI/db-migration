-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_dynamic_content_additional_info_data
-- Type: TABLE

-- Name: labgt01_v1_dynamic_content_additional_info_data; Type: TABLE; Schema: labgt01_v1; Owner: -
--

CREATE TABLE labgt01_v1.labgt01_v1_dynamic_content_additional_info_data (
    additional_info_data_id numeric NOT NULL,
    slug_url character varying(1000),
    dynamic_content_type_data_id numeric,
    asset_id numeric,
    content_id_array integer[],
    additional_info jsonb,
    date date,
    img_count numeric
);


--
