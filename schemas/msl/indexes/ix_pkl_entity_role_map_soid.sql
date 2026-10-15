-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_entity_role_map_soid
-- Type: INDEX

-- Name: ix_pkl_entity_role_map_soid; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_entity_role_map_soid ON msl.msl_entity_role_map USING btree (source_object_id);


--
