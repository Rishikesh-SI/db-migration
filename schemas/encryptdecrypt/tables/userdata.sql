-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: encryptdecrypt
-- Object: userdata
-- Type: TABLE

-- Name: userdata; Type: TABLE; Schema: encryptdecrypt; Owner: -
--

CREATE TABLE encryptdecrypt.userdata (
    client_code character varying,
    input character varying,
    output character varying,
    cryptography character varying,
    created_date timestamp without time zone
);


--
