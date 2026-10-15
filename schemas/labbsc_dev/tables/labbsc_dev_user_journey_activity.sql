-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_journey_activity
-- Type: TABLE

-- Name: labbsc_dev_user_journey_activity; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_user_journey_activity (
    user_id numeric,
    activity_id numeric,
    cart_id numeric,
    order_id numeric,
    is_paid numeric,
    payment_id numeric
);


--
