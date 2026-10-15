-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_region_master region_master_id_pk
-- Type: CONSTRAINT

-- Name: stn_region_master region_master_id_pk; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_region_master
    ADD CONSTRAINT region_master_id_pk PRIMARY KEY (region_id);


--
