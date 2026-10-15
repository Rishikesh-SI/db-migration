-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_attachment
-- Type: TABLE

-- Name: labgt_ca_attachment; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_ca_attachment (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    file_name text,
    file_type text,
    file_url text NOT NULL,
    file_size_kb integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
