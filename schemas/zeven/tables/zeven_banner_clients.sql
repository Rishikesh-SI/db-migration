-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_banner_clients
-- Type: TABLE

-- Name: zeven_banner_clients; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_banner_clients (
    id numeric NOT NULL,
    name character varying(255) NOT NULL,
    contact character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    extrainfo text NOT NULL,
    state numeric NOT NULL,
    checked_out numeric NOT NULL,
    checked_out_time timestamp without time zone NOT NULL,
    metakey text NOT NULL,
    own_prefix numeric NOT NULL,
    metakey_prefix character varying(255) NOT NULL,
    purchase_type numeric NOT NULL,
    track_clicks numeric NOT NULL,
    track_impressions numeric NOT NULL,
    si_client_id numeric
);


--
