-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_duplicate_rule
-- Type: TABLE

-- Name: labgt_ca_duplicate_rule; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_ca_duplicate_rule (
    id bigint NOT NULL,
    campaign_metadata_id bigint NOT NULL,
    duplicate_fields jsonb NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
