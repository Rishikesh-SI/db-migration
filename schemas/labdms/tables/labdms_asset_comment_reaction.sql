-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_asset_comment_reaction
-- Type: TABLE

-- Name: labdms_asset_comment_reaction; Type: TABLE; Schema: labdms; Owner: -
--

CREATE TABLE labdms.labdms_asset_comment_reaction (
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
