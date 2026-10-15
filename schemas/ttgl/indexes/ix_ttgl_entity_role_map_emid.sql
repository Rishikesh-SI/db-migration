-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttgl_entity_role_map_emid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_entity_role_map_emid ON ttgl.ttgl_entity_role_map USING btree (entity_master_id);


--
