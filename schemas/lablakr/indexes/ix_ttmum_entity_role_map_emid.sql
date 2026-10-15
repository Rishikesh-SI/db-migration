-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: lablakr; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON lablakr.lablakr_entity_role_map USING btree (entity_master_id);


--
