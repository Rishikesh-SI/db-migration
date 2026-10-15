-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_entity_role_map_soid
-- Type: INDEX

-- Name: ix_tcs_entity_role_map_soid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_entity_role_map_soid ON tcs.tcs_entity_role_map USING btree (source_object_id);


--
