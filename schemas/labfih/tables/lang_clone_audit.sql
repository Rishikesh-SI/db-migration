-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: _lang_clone_audit
-- Type: TABLE

-- Name: _lang_clone_audit; Type: TABLE; Schema: labfih; Owner: -
--

CREATE TABLE labfih._lang_clone_audit (
    run_prefix text,
    kind text,
    new_id numeric,
    created_at timestamp without time zone DEFAULT now()
);


--
