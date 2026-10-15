-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_comment_asset_master
-- Type: TABLE

-- Name: dhm_comment_asset_master; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_comment_asset_master (
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    total_reactions numeric,
    total_comments numeric
);


--
