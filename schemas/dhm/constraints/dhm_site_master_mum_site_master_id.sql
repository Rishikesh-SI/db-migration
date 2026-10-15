-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_site_master mum_site_master_id
-- Type: CONSTRAINT

-- Name: dhm_site_master mum_site_master_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_site_master
    ADD CONSTRAINT mum_site_master_id PRIMARY KEY (site_master_id);


--
