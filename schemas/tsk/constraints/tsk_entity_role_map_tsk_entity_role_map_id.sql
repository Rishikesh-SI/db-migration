-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_entity_role_map tsk_entity_role_map_id
-- Type: CONSTRAINT

-- Name: tsk_entity_role_map tsk_entity_role_map_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_entity_role_map
    ADD CONSTRAINT tsk_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
