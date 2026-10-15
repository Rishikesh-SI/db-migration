-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_newsletter_subscription
-- Type: TABLE

-- Name: zeven_newsletter_subscription; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_newsletter_subscription (
    zvn_newsletter_subscription_id numeric NOT NULL,
    email_id character varying(500),
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    is_active numeric,
    is_deleted numeric
);


--
