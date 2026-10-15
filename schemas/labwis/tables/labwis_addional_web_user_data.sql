-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_addional_web_user_data
-- Type: TABLE

-- Name: labwis_addional_web_user_data; Type: TABLE; Schema: labwis; Owner: -
--

CREATE TABLE labwis.labwis_addional_web_user_data (
    user_id numeric NOT NULL,
    platform_type numeric NOT NULL,
    install_id character varying(2000),
    push_token character varying(2000),
    push_flag boolean,
    app_id character varying(300),
    web_subs_id character varying(2000),
    web_attributes jsonb,
    device_attributes jsonb,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
