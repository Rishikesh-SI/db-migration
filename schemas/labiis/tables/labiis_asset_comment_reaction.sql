-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_asset_comment_reaction
-- Type: TABLE

-- Name: labiis_asset_comment_reaction; Type: TABLE; Schema: labiis; Owner: -
--

CREATE TABLE labiis.labiis_asset_comment_reaction (
    asset_comment_reaction_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    user_id numeric,
    comment_id numeric,
    reaction_id numeric,
    reaction_date timestamp without time zone,
    is_read numeric
);


--
