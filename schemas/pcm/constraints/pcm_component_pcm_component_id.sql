-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_component pcm_component_id
-- Type: CONSTRAINT

-- Name: pcm_component pcm_component_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_component
    ADD CONSTRAINT pcm_component_id PRIMARY KEY (component_id);


--
