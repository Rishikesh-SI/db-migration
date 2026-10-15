-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_comment_asset_master
-- Type: TABLE

-- Name: labyho_comment_asset_master; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_comment_asset_master (
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    total_reactions numeric,
    total_comments numeric
);


--
