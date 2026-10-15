-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_academy_fee
-- Type: TABLE

-- Name: labyho_academy_fee; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
