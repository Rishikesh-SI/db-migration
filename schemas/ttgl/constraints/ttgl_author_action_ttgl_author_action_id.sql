-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ttgl_author_action ttgl_author_action_id
-- Type: CONSTRAINT

-- Name: ttgl_author_action ttgl_author_action_id; Type: CONSTRAINT; Schema: ttgl; Owner: -
--

ALTER TABLE ONLY ttgl.ttgl_author_action
    ADD CONSTRAINT ttgl_author_action_id PRIMARY KEY (author_action_id);


--
