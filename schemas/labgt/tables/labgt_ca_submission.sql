-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_submission
-- Type: TABLE

-- Name: labgt_ca_submission; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_ca_submission (
    id bigint NOT NULL,
    campaign_metadata_id bigint NOT NULL,
    unique_id text,
    dedupe_key text,
    submission_json jsonb NOT NULL,
    user_guid text,
    ip_address text,
    source_domain text,
    status smallint DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
