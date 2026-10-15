-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_asset_comment_reaction
-- Type: TABLE

-- Name: labmcfc_v1_asset_comment_reaction; Type: TABLE; Schema: labmcfc_v1; Owner: -
--

CREATE TABLE labmcfc_v1.labmcfc_v1_asset_comment_reaction (
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
