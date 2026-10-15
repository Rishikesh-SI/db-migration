-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_user_asset_reaction
-- Type: TABLE

-- Name: labkc_v1_user_asset_reaction; Type: TABLE; Schema: labkc_v1_02042024; Owner: -
--

CREATE TABLE labkc_v1_02042024.labkc_v1_user_asset_reaction (
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
