-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_emailer_emails
-- Type: TABLE

-- Name: labsaw_emailer_emails; Type: TABLE; Schema: labsaw; Owner: -
--

CREATE TABLE labsaw.labsaw_emailer_emails (
    email_id text,
    user_full_name text,
    guid text,
    status numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    first_name text,
    last_name text
);


--
