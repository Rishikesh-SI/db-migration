-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_entity_role_map_soid
-- Type: INDEX

-- Name: ix_cfc_entity_role_map_soid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_entity_role_map_soid ON cfc.cfc_entity_role_map USING btree (source_object_id);


--
