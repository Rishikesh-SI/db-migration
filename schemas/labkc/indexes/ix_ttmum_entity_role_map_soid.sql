-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: ix_ttmum_entity_role_map_soid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_soid; Type: INDEX; Schema: labkc; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_soid ON labkc.labkc_entity_role_map USING btree (source_object_id);


--
