-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_daily_gratification_winners_0542022
-- Type: TABLE

-- Name: dd_daily_gratification_winners_0542022; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_daily_gratification_winners_0542022 (
    gratification_detail_id numeric,
    user_id numeric,
    event_id numeric,
    nth_num numeric,
    gift_id numeric,
    is_active numeric,
    is_deleted numeric,
    is_claimed numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
