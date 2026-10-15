-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: ix_ttmum_entity_role_map_soid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_soid; Type: INDEX; Schema: labgg; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_soid ON labgg.labgg_entity_role_map USING btree (source_object_id);


--
