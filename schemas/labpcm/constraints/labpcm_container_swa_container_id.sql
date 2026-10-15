-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_container swa_container_id
-- Type: CONSTRAINT

-- Name: labpcm_container swa_container_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_container
    ADD CONSTRAINT swa_container_id PRIMARY KEY (container_id);


--
