-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_action tfa_action_id
-- Type: CONSTRAINT

-- Name: tfa_action tfa_action_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_action
    ADD CONSTRAINT tfa_action_id PRIMARY KEY (action_id);


--
