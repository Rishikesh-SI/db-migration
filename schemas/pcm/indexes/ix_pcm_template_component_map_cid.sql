-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_template_component_map_cid
-- Type: INDEX

-- Name: ix_pcm_template_component_map_cid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_template_component_map_cid ON pcm.pcm_template_component_map USING btree (component_id);


--
