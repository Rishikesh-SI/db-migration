-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_entity_role_map_soid
-- Type: INDEX

-- Name: ix_khi_entity_role_map_soid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_entity_role_map_soid ON khi.khi_entity_role_map USING btree (source_object_id);


--
