-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_author_action rfg_author_action_id
-- Type: CONSTRAINT

-- Name: rfg_author_action rfg_author_action_id; Type: CONSTRAINT; Schema: rfg; Owner: -
--

ALTER TABLE ONLY rfg.rfg_author_action
    ADD CONSTRAINT rfg_author_action_id PRIMARY KEY (author_action_id);


--
