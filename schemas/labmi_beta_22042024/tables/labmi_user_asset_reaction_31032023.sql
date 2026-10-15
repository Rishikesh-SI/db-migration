-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_user_asset_reaction_31032023
-- Type: TABLE

-- Name: labmi_user_asset_reaction_31032023; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_user_asset_reaction_31032023 (
    user_asset_reaction_id numeric,
    user_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    reaction_id numeric,
    comment_text text,
    reaction_date timestamp without time zone,
    parent_comment_id numeric,
    is_reply_to numeric,
    is_read numeric,
    is_spam numeric,
    reported_by numeric,
    message text
);


--
