-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: ix_ttmum_entity_role_map_soid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_soid; Type: INDEX; Schema: labjdtest; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_soid ON labjdtest.labjdtest_entity_role_map USING btree (source_object_id);


--
