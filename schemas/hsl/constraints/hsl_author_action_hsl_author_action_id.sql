-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_author_action hsl_author_action_id
-- Type: CONSTRAINT

-- Name: hsl_author_action hsl_author_action_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_author_action
    ADD CONSTRAINT hsl_author_action_id PRIMARY KEY (author_action_id);


--
