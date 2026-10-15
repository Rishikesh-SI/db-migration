-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_component_type mum_component_type_id
-- Type: CONSTRAINT

-- Name: dhm_component_type mum_component_type_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_component_type
    ADD CONSTRAINT mum_component_type_id PRIMARY KEY (component_type_id);


--
