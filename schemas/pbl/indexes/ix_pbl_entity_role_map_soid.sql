-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_entity_role_map_soid
-- Type: INDEX

-- Name: ix_pbl_entity_role_map_soid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_entity_role_map_soid ON pbl.pbl_entity_role_map USING btree (source_object_id);


--
