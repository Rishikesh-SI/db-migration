-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_author_action mum_author_action_id
-- Type: CONSTRAINT

-- Name: dhm_author_action mum_author_action_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_author_action
    ADD CONSTRAINT mum_author_action_id PRIMARY KEY (author_action_id);


--
