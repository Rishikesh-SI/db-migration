-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_entity_role_map_soid
-- Type: INDEX

-- Name: ix_swa_entity_role_map_soid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_entity_role_map_soid ON swa.swa_entity_role_map USING btree (source_object_id);


--
