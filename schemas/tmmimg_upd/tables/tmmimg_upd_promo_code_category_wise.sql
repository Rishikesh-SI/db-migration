-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_promo_code_category_wise
-- Type: TABLE

-- Name: tmmimg_upd_promo_code_category_wise; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_promo_code_category_wise (
    promo_code_id numeric,
    promo_code text,
    is_active numeric,
    is_deleted numeric,
    is_send_user numeric,
    created_date timestamp without time zone,
    category_id numeric
);


--
