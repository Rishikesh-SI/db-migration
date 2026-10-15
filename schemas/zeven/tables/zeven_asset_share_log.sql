-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_asset_share_log
-- Type: TABLE

-- Name: zeven_asset_share_log; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_asset_share_log (
    shareid numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_owner numeric NOT NULL,
    asset_status numeric,
    offered_to numeric,
    createdby numeric,
    createddate timestamp without time zone,
    updatedby numeric,
    updateddate timestamp without time zone,
    catid numeric,
    asset_alias character varying(200),
    si_client_id numeric
);


--
