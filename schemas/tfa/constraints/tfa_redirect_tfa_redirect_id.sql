-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_redirect tfa_redirect_id
-- Type: CONSTRAINT

-- Name: tfa_redirect tfa_redirect_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_redirect
    ADD CONSTRAINT tfa_redirect_id PRIMARY KEY (redirect_id);


--
