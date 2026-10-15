-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_entity_role_map_soid
-- Type: INDEX

-- Name: ix_isl_entity_role_map_soid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_entity_role_map_soid ON isl.isl_entity_role_map USING btree (source_object_id);


--
