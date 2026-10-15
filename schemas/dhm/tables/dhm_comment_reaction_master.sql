-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_comment_reaction_master
-- Type: TABLE

-- Name: dhm_comment_reaction_master; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_comment_reaction_master (
    comment_id numeric NOT NULL,
    total_reactions numeric,
    total_reply numeric,
    user_id numeric,
    comment_text text
);


--
