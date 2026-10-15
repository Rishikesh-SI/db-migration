-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_author_action labgrl_author_action_id
-- Type: CONSTRAINT

-- Name: labgrl_author_action labgrl_author_action_id; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_author_action
    ADD CONSTRAINT labgrl_author_action_id PRIMARY KEY (author_action_id);


--
