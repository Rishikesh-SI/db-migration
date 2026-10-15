-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_entity_type scom_entity_type_id
-- Type: CONSTRAINT

-- Name: scom_entity_type scom_entity_type_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_entity_type
    ADD CONSTRAINT scom_entity_type_id PRIMARY KEY (entity_type_id);


--
