-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_entity_role scom_entity_role_id
-- Type: CONSTRAINT

-- Name: scom_entity_role scom_entity_role_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_entity_role
    ADD CONSTRAINT scom_entity_role_id PRIMARY KEY (entity_role_id);


--
