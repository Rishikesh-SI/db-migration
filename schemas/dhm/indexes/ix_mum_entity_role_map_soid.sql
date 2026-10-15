-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_entity_role_map_soid
-- Type: INDEX

-- Name: ix_mum_entity_role_map_soid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_entity_role_map_soid ON dhm.dhm_entity_role_map USING btree (source_object_id);


--
