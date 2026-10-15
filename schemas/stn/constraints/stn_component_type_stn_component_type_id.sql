-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_component_type stn_component_type_id
-- Type: CONSTRAINT

-- Name: stn_component_type stn_component_type_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_component_type
    ADD CONSTRAINT stn_component_type_id PRIMARY KEY (component_type_id);


--
