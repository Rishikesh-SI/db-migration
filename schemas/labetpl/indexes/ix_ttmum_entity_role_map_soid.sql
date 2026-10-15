-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: ix_ttmum_entity_role_map_soid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_soid; Type: INDEX; Schema: labetpl; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_soid ON labetpl.labetpl_entity_role_map USING btree (source_object_id);


--
