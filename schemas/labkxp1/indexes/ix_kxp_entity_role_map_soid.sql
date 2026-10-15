-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_entity_role_map_soid
-- Type: INDEX

-- Name: ix_kxp_entity_role_map_soid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_entity_role_map_soid ON labkxp1.labkxp_entity_role_map USING btree (source_object_id);


--
