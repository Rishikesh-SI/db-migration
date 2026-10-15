-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_sunday_contest_winner
-- Type: TABLE

-- Name: isl_sunday_contest_winner; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_sunday_contest_winner (
    sunday_contest_winner_id numeric NOT NULL,
    poll_id numeric,
    module_name text,
    firstname text,
    dob date,
    lastname text,
    pincode text,
    phone text,
    email text,
    userfrom text,
    country text,
    contestsource text,
    question text,
    answer text,
    poll_option_id numeric,
    bike_winner numeric
);


--
