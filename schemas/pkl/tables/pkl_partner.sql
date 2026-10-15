-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_partner
-- Type: TABLE

-- Name: pkl_partner; Type: TABLE; Schema: pkl; Owner: -
--

CREATE TABLE pkl.pkl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
