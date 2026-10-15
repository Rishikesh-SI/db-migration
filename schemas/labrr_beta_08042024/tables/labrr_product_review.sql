-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_product_review
-- Type: TABLE

-- Name: labrr_product_review; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_product_review (
    product_review_id numeric NOT NULL,
    product_id numeric,
    store character varying(500),
    user_id numeric,
    customer_email_id character varying(500),
    review_title character varying(1000),
    review_text text,
    replay_text text,
    rating numeric,
    is_approved numeric,
    review_json json,
    review_date timestamp without time zone,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    review_guid character varying(100),
    is_active numeric,
    is_deleted numeric,
    is_published numeric
);


--
