-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_review
-- Type: TABLE

-- Name: labmi_product_review; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_product_review (
    product_review_id numeric NOT NULL,
    product_id numeric NOT NULL,
    store character varying(500),
    user_id numeric,
    customer_email_id character varying(500) NOT NULL,
    review_title character varying(1000) NOT NULL,
    review_text text NOT NULL,
    replay_text text,
    rating numeric,
    is_approved numeric,
    review_json json,
    review_date timestamp without time zone NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    created_by numeric NOT NULL,
    updated_by numeric,
    review_guid character varying(100) NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL
);


--
