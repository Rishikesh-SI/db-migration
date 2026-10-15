-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_report_field_map
-- Type: TABLE

-- Name: labgt_ca_report_field_map; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_ca_report_field_map (
    id bigint NOT NULL,
    campaign_metadata_id bigint NOT NULL,
    json_path text NOT NULL,
    column_alias text NOT NULL,
    data_type text DEFAULT 'text'::text NOT NULL,
    display_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
