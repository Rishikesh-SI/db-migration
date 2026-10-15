-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_daily_gift_count
-- Type: TABLE

-- Name: dd_daily_gift_count; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_daily_gift_count (
    gift_date date,
    gift_count numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
