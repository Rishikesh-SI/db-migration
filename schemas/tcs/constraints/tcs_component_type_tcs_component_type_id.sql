-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_component_type tcs_component_type_id
-- Type: CONSTRAINT

-- Name: tcs_component_type tcs_component_type_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_component_type
    ADD CONSTRAINT tcs_component_type_id PRIMARY KEY (component_type_id);


--
