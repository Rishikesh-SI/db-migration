-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_entity_role_map_emid
-- Type: INDEX

-- Name: ix_upy_entity_role_map_emid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_entity_role_map_emid ON upy.upy_entity_role_map USING btree (entity_master_id);


--
