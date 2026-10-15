-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_entity_role_map_soid
-- Type: INDEX

-- Name: ix_mum_entity_role_map_soid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_entity_role_map_soid ON tmm.tmm_entity_role_map USING btree (source_object_id);


--
