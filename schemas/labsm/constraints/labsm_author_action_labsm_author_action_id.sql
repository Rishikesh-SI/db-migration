-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_author_action labsm_author_action_id
-- Type: CONSTRAINT

-- Name: labsm_author_action labsm_author_action_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_author_action
    ADD CONSTRAINT labsm_author_action_id PRIMARY KEY (author_action_id);


--
