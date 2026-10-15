-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_author_action tfa_author_action_id
-- Type: CONSTRAINT

-- Name: tfa_author_action tfa_author_action_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_author_action
    ADD CONSTRAINT tfa_author_action_id PRIMARY KEY (author_action_id);


--
