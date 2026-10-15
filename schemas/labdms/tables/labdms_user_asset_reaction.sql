-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_user_asset_reaction
-- Type: TABLE

-- Name: labdms_user_asset_reaction; Type: TABLE; Schema: labdms; Owner: -
--

CREATE TABLE labdms.labdms_user_asset_reaction (
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
    is_read numeric,
    is_app numeric,
    platform_id numeric
);


--
