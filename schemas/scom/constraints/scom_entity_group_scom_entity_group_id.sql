-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_entity_group scom_entity_group_id
-- Type: CONSTRAINT

-- Name: scom_entity_group scom_entity_group_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_entity_group
    ADD CONSTRAINT scom_entity_group_id PRIMARY KEY (entity_group_id);


--
