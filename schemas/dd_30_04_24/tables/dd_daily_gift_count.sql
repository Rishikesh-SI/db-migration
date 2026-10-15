-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_daily_gift_count
-- Type: TABLE

-- Name: dd_daily_gift_count; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_daily_gift_count (
    gift_date date,
    gift_count numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
