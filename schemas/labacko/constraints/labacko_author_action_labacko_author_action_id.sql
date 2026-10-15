-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_author_action labacko_author_action_id
-- Type: CONSTRAINT

-- Name: labacko_author_action labacko_author_action_id; Type: CONSTRAINT; Schema: labacko; Owner: -
--

ALTER TABLE ONLY labacko.labacko_author_action
    ADD CONSTRAINT labacko_author_action_id PRIMARY KEY (author_action_id);


--
