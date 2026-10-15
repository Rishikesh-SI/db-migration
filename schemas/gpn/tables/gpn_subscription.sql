-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_subscription
-- Type: TABLE

-- Name: gpn_subscription; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_subscription (
    subscription_id numeric NOT NULL,
    subscription_name character varying(100) NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
