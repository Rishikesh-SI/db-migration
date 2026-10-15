-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_component_type pcm_component_type_id
-- Type: CONSTRAINT

-- Name: pcm_component_type pcm_component_type_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_component_type
    ADD CONSTRAINT pcm_component_type_id PRIMARY KEY (component_type_id);


--
