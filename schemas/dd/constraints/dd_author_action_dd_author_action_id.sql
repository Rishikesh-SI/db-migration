-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_author_action dd_author_action_id
-- Type: CONSTRAINT

-- Name: dd_author_action dd_author_action_id; Type: CONSTRAINT; Schema: dd; Owner: -
--

ALTER TABLE ONLY dd.dd_author_action
    ADD CONSTRAINT dd_author_action_id PRIMARY KEY (author_action_id);


--
