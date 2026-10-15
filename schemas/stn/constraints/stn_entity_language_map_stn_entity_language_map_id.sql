-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_entity_language_map stn_entity_language_map_id
-- Type: CONSTRAINT

-- Name: stn_entity_language_map stn_entity_language_map_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_entity_language_map
    ADD CONSTRAINT stn_entity_language_map_id PRIMARY KEY (entity_language_map_id);


--
