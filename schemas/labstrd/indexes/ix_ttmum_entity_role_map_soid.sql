-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: ix_ttmum_entity_role_map_soid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_soid; Type: INDEX; Schema: labstrd; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_soid ON labstrd.labstrd_entity_role_map USING btree (source_object_id);


--
