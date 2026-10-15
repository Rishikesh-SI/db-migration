-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_email_activity_user_map
-- Type: TABLE

-- Name: isl_email_activity_user_map; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_email_activity_user_map (
    activity_id numeric,
    user_name text,
    email_id text,
    batch_id numeric,
    status numeric
);


--
