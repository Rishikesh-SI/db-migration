-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: labtkr_user_asset_reaction
-- Type: TABLE

-- Name: labtkr_user_asset_reaction; Type: TABLE; Schema: labtkr_beta; Owner: -
--

CREATE TABLE labtkr_beta.labtkr_user_asset_reaction (
    user_asset_reaction_id numeric NOT NULL,
    user_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    reaction_id numeric,
    comment_text text,
    reaction_date timestamp without time zone,
    parent_comment_id numeric,
    is_reply_to numeric,
    is_deleted numeric,
    is_read numeric
);


--
