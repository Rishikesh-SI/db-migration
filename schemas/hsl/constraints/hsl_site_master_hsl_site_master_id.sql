-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_site_master hsl_site_master_id
-- Type: CONSTRAINT

-- Name: hsl_site_master hsl_site_master_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_site_master
    ADD CONSTRAINT hsl_site_master_id PRIMARY KEY (site_master_id);


--
