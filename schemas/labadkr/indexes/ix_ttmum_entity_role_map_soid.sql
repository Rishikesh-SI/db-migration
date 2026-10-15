-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: ix_ttmum_entity_role_map_soid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_soid; Type: INDEX; Schema: labadkr; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_soid ON labadkr.labadkr_entity_role_map USING btree (source_object_id);


--
