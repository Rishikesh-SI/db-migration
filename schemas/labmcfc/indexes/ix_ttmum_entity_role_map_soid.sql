-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: ix_ttmum_entity_role_map_soid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_soid; Type: INDEX; Schema: labmcfc; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_soid ON labmcfc.labmcfc_entity_role_map USING btree (source_object_id);


--
