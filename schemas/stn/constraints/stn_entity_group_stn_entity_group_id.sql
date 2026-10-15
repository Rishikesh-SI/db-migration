-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_entity_group stn_entity_group_id
-- Type: CONSTRAINT

-- Name: stn_entity_group stn_entity_group_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_entity_group
    ADD CONSTRAINT stn_entity_group_id PRIMARY KEY (entity_group_id);


--
