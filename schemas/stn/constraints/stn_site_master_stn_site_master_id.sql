-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_site_master stn_site_master_id
-- Type: CONSTRAINT

-- Name: stn_site_master stn_site_master_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_site_master
    ADD CONSTRAINT stn_site_master_id PRIMARY KEY (site_master_id);


--
