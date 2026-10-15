-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_campaign_metadata
-- Type: TABLE

-- Name: labgt_ca_campaign_metadata; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_ca_campaign_metadata (
    id bigint NOT NULL,
    module_name text NOT NULL,
    module_type text NOT NULL,
    allow_duplicate boolean DEFAULT true NOT NULL,
    generate_unique_id boolean DEFAULT false NOT NULL,
    unique_prefix text,
    sequence_name text,
    report_enabled boolean DEFAULT false NOT NULL,
    attachment_enabled boolean DEFAULT false NOT NULL,
    questionnaire_enabled boolean DEFAULT false NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    config_json jsonb,
    created_by text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone,
    CONSTRAINT labgt_ca_campaign_metadata_module_type_check CHECK ((module_type = ANY (ARRAY['contact'::text, 'custom_web'::text])))
);


--
