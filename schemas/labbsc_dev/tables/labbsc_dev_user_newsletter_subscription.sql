-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_newsletter_subscription
-- Type: TABLE

-- Name: labbsc_dev_user_newsletter_subscription; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_user_newsletter_subscription (
    user_id numeric NOT NULL,
    cart_id numeric,
    valid_till timestamp without time zone,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_emailer_sent numeric,
    emailer_sent_date timestamp without time zone
);


--
