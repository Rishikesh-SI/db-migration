-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_addional_web_user_data
-- Type: TABLE

-- Name: lablsg_v1_addional_web_user_data; Type: TABLE; Schema: lablsg_v1; Owner: -
--

CREATE TABLE lablsg_v1.lablsg_v1_addional_web_user_data (
    user_id numeric,
    platform_type numeric,
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
