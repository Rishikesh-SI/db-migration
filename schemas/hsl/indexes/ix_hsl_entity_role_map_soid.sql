-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_entity_role_map_soid
-- Type: INDEX

-- Name: ix_hsl_entity_role_map_soid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_entity_role_map_soid ON hsl.hsl_entity_role_map USING btree (source_object_id);


--
