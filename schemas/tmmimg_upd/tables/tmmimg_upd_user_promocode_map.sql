-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_user_promocode_map
-- Type: TABLE

-- Name: tmmimg_upd_user_promocode_map; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_user_promocode_map (
    promo_code text,
    email_id text,
    is_send numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
