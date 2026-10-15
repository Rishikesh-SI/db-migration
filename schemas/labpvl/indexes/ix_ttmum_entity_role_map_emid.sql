-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labpvl.labpvl_entity_role_map USING btree (entity_master_id);


--
