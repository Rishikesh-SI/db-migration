-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_entity_role_map_soid
-- Type: INDEX

-- Name: ix_rfg_entity_role_map_soid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_entity_role_map_soid ON rfg.rfg_entity_role_map USING btree (source_object_id);


--
