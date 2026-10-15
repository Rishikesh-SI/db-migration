-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_entity_role_map_emid
-- Type: INDEX

-- Name: ix_tcs_entity_role_map_emid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_entity_role_map_emid ON tcs.tcs_entity_role_map USING btree (entity_master_id);


--
