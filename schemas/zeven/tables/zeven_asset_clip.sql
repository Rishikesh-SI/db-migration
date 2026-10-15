-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_asset_clip
-- Type: TABLE

-- Name: zeven_asset_clip; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_asset_clip (
    asset_clip_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    alias character varying(1200),
    resolutionid numeric NOT NULL,
    width numeric NOT NULL,
    height numeric NOT NULL,
    url character varying(4000),
    filetype_decodeid numeric(6,0),
    filesize character varying(200),
    bitrate numeric(6,0),
    duration character varying(200),
    video_profileid numeric(6,0),
    si_client_id numeric(6,0)
);


--
