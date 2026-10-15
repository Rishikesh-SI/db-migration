-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_bisleri_daily_gift_count
-- Type: TABLE

-- Name: labtcs_bisleri_daily_gift_count; Type: TABLE; Schema: labtcs; Owner: -
--

CREATE TABLE labtcs.labtcs_bisleri_daily_gift_count (
    gift_date date,
    gift_count numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
