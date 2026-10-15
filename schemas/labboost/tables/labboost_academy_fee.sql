-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_academy_fee
-- Type: TABLE

-- Name: labboost_academy_fee; Type: TABLE; Schema: labboost; Owner: -
--

CREATE TABLE labboost.labboost_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
