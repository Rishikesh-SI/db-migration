-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_site_master pcm_site_master_id
-- Type: CONSTRAINT

-- Name: pcm_site_master pcm_site_master_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_site_master
    ADD CONSTRAINT pcm_site_master_id PRIMARY KEY (site_master_id);


--
