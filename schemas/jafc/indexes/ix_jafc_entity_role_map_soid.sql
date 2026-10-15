-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_entity_role_map_soid
-- Type: INDEX

-- Name: ix_jafc_entity_role_map_soid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_entity_role_map_soid ON jafc.jafc_entity_role_map USING btree (source_object_id);


--
