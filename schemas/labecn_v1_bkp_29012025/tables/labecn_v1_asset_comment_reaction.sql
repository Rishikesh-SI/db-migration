-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: labecn_v1_asset_comment_reaction
-- Type: TABLE

-- Name: labecn_v1_asset_comment_reaction; Type: TABLE; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE TABLE labecn_v1_bkp_29012025.labecn_v1_asset_comment_reaction (
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
