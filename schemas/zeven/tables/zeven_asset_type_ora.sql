-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_asset_type_ora
-- Type: TABLE

-- Name: zeven_asset_type_ora; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_asset_type_ora (
    asset_type_id numeric NOT NULL,
    asset_name character varying(100) NOT NULL,
    asset_desc character varying(100),
    si_client_id numeric
);


--
