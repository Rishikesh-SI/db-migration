-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_entity_role_map_soid
-- Type: INDEX

-- Name: ix_spz_entity_role_map_soid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_entity_role_map_soid ON spz.spz_entity_role_map USING btree (source_object_id);


--
