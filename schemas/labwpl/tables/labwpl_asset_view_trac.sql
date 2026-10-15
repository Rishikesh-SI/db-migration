-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_asset_view_trac
-- Type: TABLE

-- Name: labwpl_asset_view_trac; Type: TABLE; Schema: labwpl; Owner: -
--

CREATE TABLE labwpl.labwpl_asset_view_trac (
    asset_view_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    user_guid character varying,
    url text,
    share text,
    viewed_date timestamp without time zone,
    is_action text,
    data_guid character varying(500)
);


--
