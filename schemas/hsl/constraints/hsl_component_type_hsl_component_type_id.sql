-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_component_type hsl_component_type_id
-- Type: CONSTRAINT

-- Name: hsl_component_type hsl_component_type_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_component_type
    ADD CONSTRAINT hsl_component_type_id PRIMARY KEY (component_type_id);


--
