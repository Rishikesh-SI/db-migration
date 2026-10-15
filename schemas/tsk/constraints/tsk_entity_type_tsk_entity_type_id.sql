-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_entity_type tsk_entity_type_id
-- Type: CONSTRAINT

-- Name: tsk_entity_type tsk_entity_type_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_entity_type
    ADD CONSTRAINT tsk_entity_type_id PRIMARY KEY (entity_type_id);


--
