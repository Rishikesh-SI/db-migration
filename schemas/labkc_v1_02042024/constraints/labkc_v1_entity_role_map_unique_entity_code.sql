-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_entity_role_map unique_entity_code
-- Type: CONSTRAINT

-- Name: labkc_v1_entity_role_map unique_entity_code; Type: CONSTRAINT; Schema: labkc_v1_02042024; Owner: -
--

ALTER TABLE ONLY labkc_v1_02042024.labkc_v1_entity_role_map
    ADD CONSTRAINT unique_entity_code UNIQUE (entity_code);


--
