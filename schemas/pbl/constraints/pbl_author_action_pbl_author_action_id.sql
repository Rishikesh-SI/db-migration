-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_author_action pbl_author_action_id
-- Type: CONSTRAINT

-- Name: pbl_author_action pbl_author_action_id; Type: CONSTRAINT; Schema: pbl; Owner: -
--

ALTER TABLE ONLY pbl.pbl_author_action
    ADD CONSTRAINT pbl_author_action_id PRIMARY KEY (author_action_id);


--
