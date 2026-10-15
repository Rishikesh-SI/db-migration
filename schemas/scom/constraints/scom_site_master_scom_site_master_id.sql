-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_site_master scom_site_master_id
-- Type: CONSTRAINT

-- Name: scom_site_master scom_site_master_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_site_master
    ADD CONSTRAINT scom_site_master_id PRIMARY KEY (site_master_id);


--
