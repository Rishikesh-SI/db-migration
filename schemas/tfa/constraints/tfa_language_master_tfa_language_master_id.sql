-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_language_master tfa_language_master_id
-- Type: CONSTRAINT

-- Name: tfa_language_master tfa_language_master_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_language_master
    ADD CONSTRAINT tfa_language_master_id PRIMARY KEY (language_master_id);


--
