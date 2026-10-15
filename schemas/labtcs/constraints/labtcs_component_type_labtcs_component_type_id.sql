-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_component_type labtcs_component_type_id
-- Type: CONSTRAINT

-- Name: labtcs_component_type labtcs_component_type_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_component_type
    ADD CONSTRAINT labtcs_component_type_id PRIMARY KEY (component_type_id);


--
