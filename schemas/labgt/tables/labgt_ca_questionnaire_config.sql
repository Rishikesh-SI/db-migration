-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_questionnaire_config
-- Type: TABLE

-- Name: labgt_ca_questionnaire_config; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_ca_questionnaire_config (
    id bigint NOT NULL,
    campaign_metadata_id bigint NOT NULL,
    questions jsonb DEFAULT '[]'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


--
