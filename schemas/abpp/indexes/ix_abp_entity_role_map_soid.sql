-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_entity_role_map_soid
-- Type: INDEX

-- Name: ix_abp_entity_role_map_soid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_entity_role_map_soid ON abpp.abp_entity_role_map USING btree (source_object_id);


--
