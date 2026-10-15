-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_author_action upy_author_action_id
-- Type: CONSTRAINT

-- Name: upy_author_action upy_author_action_id; Type: CONSTRAINT; Schema: upy; Owner: -
--

ALTER TABLE ONLY upy.upy_author_action
    ADD CONSTRAINT upy_author_action_id PRIMARY KEY (author_action_id);


--
