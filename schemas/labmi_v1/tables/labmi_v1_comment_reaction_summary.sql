-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_comment_reaction_summary
-- Type: TABLE

-- Name: labmi_v1_comment_reaction_summary; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_comment_reaction_summary (
    asset_id numeric,
    asset_type_id numeric,
    comment_id numeric,
    comment_text text,
    reaction_date timestamp without time zone,
    user_id numeric,
    latest_reply numeric,
    total_reactions numeric,
    total_replies numeric
);


--
