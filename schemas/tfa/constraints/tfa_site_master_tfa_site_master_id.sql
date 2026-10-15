-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_site_master tfa_site_master_id
-- Type: CONSTRAINT

-- Name: tfa_site_master tfa_site_master_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_site_master
    ADD CONSTRAINT tfa_site_master_id PRIMARY KEY (site_master_id);


--
