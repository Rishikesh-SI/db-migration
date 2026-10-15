-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_author_action swa_author_action_id
-- Type: CONSTRAINT

-- Name: swa_author_action swa_author_action_id; Type: CONSTRAINT; Schema: swa; Owner: -
--

ALTER TABLE ONLY swa.swa_author_action
    ADD CONSTRAINT swa_author_action_id PRIMARY KEY (author_action_id);


--
