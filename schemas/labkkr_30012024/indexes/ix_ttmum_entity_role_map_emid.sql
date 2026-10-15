-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labkkr_30012024; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labkkr_30012024.labkkr_entity_role_map USING btree (entity_master_id);


--
