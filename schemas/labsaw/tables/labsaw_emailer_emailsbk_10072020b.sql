-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_emailer_emailsbk_10072020b
-- Type: TABLE

-- Name: labsaw_emailer_emailsbk_10072020b; Type: TABLE; Schema: labsaw; Owner: -
--

CREATE TABLE labsaw.labsaw_emailer_emailsbk_10072020b (
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
