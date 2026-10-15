-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_assets_view
-- Type: TABLE

-- Name: labhkind_assets_view; Type: TABLE; Schema: labhkind; Owner: -
--

CREATE TABLE labhkind.labhkind_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
