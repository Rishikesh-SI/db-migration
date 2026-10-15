-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_comment_reaction_summary
-- Type: TABLE

-- Name: isl_comment_reaction_summary; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_comment_reaction_summary (
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    comment_id numeric NOT NULL,
    comment_text text,
    reaction_date timestamp without time zone,
    user_id numeric NOT NULL,
    latest_reply numeric,
    total_reactions numeric,
    total_replies numeric
);


--
