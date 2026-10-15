-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labgt01_v1.labgt01_v1_entity_role_map USING btree (entity_master_id);


--
