-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_whatsapp_bot_user
-- Type: TABLE

-- Name: labmi_whatsapp_bot_user; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_whatsapp_bot_user (
    whatsapp_bot_user_id numeric NOT NULL,
    mobile_no character varying(250),
    email_id character varying(1000),
    dob character varying(1000),
    gender character varying(1000),
    created_date timestamp without time zone,
    favorite_player text
);


--
