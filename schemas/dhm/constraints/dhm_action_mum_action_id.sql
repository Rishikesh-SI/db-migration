-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_action mum_action_id
-- Type: CONSTRAINT

-- Name: dhm_action mum_action_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_action
    ADD CONSTRAINT mum_action_id PRIMARY KEY (action_id);


--
