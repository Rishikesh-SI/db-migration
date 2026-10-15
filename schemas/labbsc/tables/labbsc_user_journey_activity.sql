-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_user_journey_activity
-- Type: TABLE

-- Name: labbsc_user_journey_activity; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_user_journey_activity (
    user_id numeric,
    activity_id numeric,
    cart_id numeric,
    order_id numeric,
    is_paid numeric,
    payment_id numeric
);


--
