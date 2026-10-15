-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labgmr; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labgmr.labgmr_entity_role_map USING btree (entity_master_id);


--
