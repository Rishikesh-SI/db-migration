-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_user_newsletter_subscription
-- Type: TABLE

-- Name: labbsc_user_newsletter_subscription; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_user_newsletter_subscription (
    user_id numeric NOT NULL,
    cart_id numeric,
    valid_till timestamp without time zone,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_emailer_sent numeric,
    emailer_sent_date timestamp without time zone
);


--
