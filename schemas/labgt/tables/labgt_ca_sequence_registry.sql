-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_sequence_registry
-- Type: TABLE

-- Name: labgt_ca_sequence_registry; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_ca_sequence_registry (
    id bigint NOT NULL,
    campaign_metadata_id bigint NOT NULL,
    sequence_name text NOT NULL,
    unique_prefix text,
    padding_length integer DEFAULT 6 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
