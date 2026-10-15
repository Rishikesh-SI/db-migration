-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: labecn_v1_content_type_fields
-- Type: TABLE

-- Name: labecn_v1_content_type_fields; Type: TABLE; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE TABLE labecn_v1_bkp_29012025.labecn_v1_content_type_fields (
    content_type_field_id numeric NOT NULL,
    content_type_id numeric,
    field_name character varying,
    field_data_type character varying,
    field_defaultvalue character varying,
    field_type character varying,
    field_label character varying,
    show_in_listing_json boolean,
    is_active numeric,
    is_deleted numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    order_no numeric,
    settingjson jsonb,
    is_required boolean
);


--
