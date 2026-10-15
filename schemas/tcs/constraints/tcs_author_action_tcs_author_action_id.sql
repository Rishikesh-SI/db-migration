-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_author_action tcs_author_action_id
-- Type: CONSTRAINT

-- Name: tcs_author_action tcs_author_action_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_author_action
    ADD CONSTRAINT tcs_author_action_id PRIMARY KEY (author_action_id);


--
