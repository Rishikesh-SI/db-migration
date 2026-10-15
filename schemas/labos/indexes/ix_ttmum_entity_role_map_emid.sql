-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labos; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labos.labos_entity_role_map USING btree (entity_master_id);


--
