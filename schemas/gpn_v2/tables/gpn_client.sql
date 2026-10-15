-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_client
-- Type: TABLE

-- Name: gpn_client; Type: TABLE; Schema: gpn_v2; Owner: -
--

CREATE TABLE gpn_v2.gpn_client (
    client_id numeric,
    client_name text,
    client_table_suffix character varying(5),
    image_json jsonb,
    client_code character varying(10),
    notification_setting jsonb
);


--
