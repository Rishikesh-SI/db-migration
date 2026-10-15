-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: ttmum; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON ttmum.ttmum_entity_role_map USING btree (entity_master_id);


--
