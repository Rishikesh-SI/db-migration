-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labrstg.labrstg_entity_role_map USING btree (entity_master_id);


--
