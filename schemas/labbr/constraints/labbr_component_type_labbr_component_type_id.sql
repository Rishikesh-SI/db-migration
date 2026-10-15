-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_component_type labbr_component_type_id
-- Type: CONSTRAINT

-- Name: labbr_component_type labbr_component_type_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_component_type
    ADD CONSTRAINT labbr_component_type_id PRIMARY KEY (component_type_id);


--
