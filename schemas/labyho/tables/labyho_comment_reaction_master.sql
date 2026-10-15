-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_comment_reaction_master
-- Type: TABLE

-- Name: labyho_comment_reaction_master; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_comment_reaction_master (
    comment_id numeric NOT NULL,
    total_reactions numeric,
    total_reply numeric,
    user_id numeric,
    comment_text text
);


--
