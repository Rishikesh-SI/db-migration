-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: ix_ttmum_entity_role_map_soid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_soid; Type: INDEX; Schema: labbr; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_soid ON labbr.labbr_entity_role_map USING btree (source_object_id);


--
