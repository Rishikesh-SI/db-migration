-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_academy_fee
-- Type: TABLE

-- Name: labacko_academy_fee; Type: TABLE; Schema: labacko; Owner: -
--

CREATE TABLE labacko.labacko_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
