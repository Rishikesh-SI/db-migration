-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_asset_comment_reaction
-- Type: TABLE

-- Name: labrao_asset_comment_reaction; Type: TABLE; Schema: labrao; Owner: -
--

CREATE TABLE labrao.labrao_asset_comment_reaction (
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
