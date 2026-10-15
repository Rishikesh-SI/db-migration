-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_author_action msl_author_action_id
-- Type: CONSTRAINT

-- Name: msl_author_action msl_author_action_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_author_action
    ADD CONSTRAINT msl_author_action_id PRIMARY KEY (author_action_id);


--
