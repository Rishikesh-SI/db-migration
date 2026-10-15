-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_template swa_template_id
-- Type: CONSTRAINT

-- Name: tfa_template swa_template_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_template
    ADD CONSTRAINT swa_template_id PRIMARY KEY (template_id);


--
