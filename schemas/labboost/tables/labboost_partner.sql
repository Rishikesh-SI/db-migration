-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_partner
-- Type: TABLE

-- Name: labboost_partner; Type: TABLE; Schema: labboost; Owner: -
--

CREATE TABLE labboost.labboost_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
