-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_entity_role_map_soid
-- Type: INDEX

-- Name: ix_tsk_entity_role_map_soid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_entity_role_map_soid ON tsk.tsk_entity_role_map USING btree (source_object_id);


--
