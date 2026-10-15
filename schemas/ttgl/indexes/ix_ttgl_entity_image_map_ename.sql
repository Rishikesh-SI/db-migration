-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_entity_image_map_ename
-- Type: INDEX

-- Name: ix_ttgl_entity_image_map_ename; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_entity_image_map_ename ON ttgl.ttgl_entity_image_map USING btree (entity_master_id);


--
