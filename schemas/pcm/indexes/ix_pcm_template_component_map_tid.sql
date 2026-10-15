-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_template_component_map_tid
-- Type: INDEX

-- Name: ix_pcm_template_component_map_tid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_template_component_map_tid ON pcm.pcm_template_component_map USING btree (template_id);


--
