-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_entity_master labwis_entity_master_canonical_url_key
-- Type: CONSTRAINT

-- Name: labwis_entity_master labwis_entity_master_canonical_url_key; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_entity_master
    ADD CONSTRAINT labwis_entity_master_canonical_url_key UNIQUE (canonical_url);


--
