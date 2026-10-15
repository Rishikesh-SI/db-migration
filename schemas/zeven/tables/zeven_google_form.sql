-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_google_form
-- Type: TABLE

-- Name: zeven_google_form; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_google_form (
    zeven_google_form_id numeric NOT NULL,
    user_id numeric,
    email character varying(200),
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    is_active numeric,
    is_deleted numeric
);


--
