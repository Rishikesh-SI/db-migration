-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_promo_code_category_wise
-- Type: TABLE

-- Name: tmm_promo_code_category_wise; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_promo_code_category_wise (
    promo_code_id numeric,
    promo_code text,
    is_active numeric,
    is_deleted numeric,
    is_send_user numeric,
    created_date timestamp without time zone,
    category_id numeric
);


--
