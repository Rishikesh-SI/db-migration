-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_component_layout pcm_component_layout_id
-- Type: CONSTRAINT

-- Name: pcm_component_layout pcm_component_layout_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_component_layout
    ADD CONSTRAINT pcm_component_layout_id PRIMARY KEY (component_layout_id);


--
