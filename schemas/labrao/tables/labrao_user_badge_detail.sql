-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_user_badge_detail
-- Type: TABLE

-- Name: labrao_user_badge_detail; Type: TABLE; Schema: labrao; Owner: -
--

CREATE TABLE labrao.labrao_user_badge_detail (
    user_id numeric,
    activity_date date,
    last_activity_date date,
    curr_activity_date date,
    first_activity_date date,
    days_3 numeric,
    days_5 numeric,
    days_7 numeric
);


--
