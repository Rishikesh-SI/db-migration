-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_container swa_container_id
-- Type: CONSTRAINT

-- Name: tfa_container swa_container_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_container
    ADD CONSTRAINT swa_container_id PRIMARY KEY (container_id);


--
