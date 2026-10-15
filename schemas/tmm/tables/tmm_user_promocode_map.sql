-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_user_promocode_map
-- Type: TABLE

-- Name: tmm_user_promocode_map; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_user_promocode_map (
    promo_code text,
    email_id text,
    is_send numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
