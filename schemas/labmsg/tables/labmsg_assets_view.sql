-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_assets_view
-- Type: TABLE

-- Name: labmsg_assets_view; Type: TABLE; Schema: labmsg; Owner: -
--

CREATE TABLE labmsg.labmsg_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
