-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_entity_role_map_soid
-- Type: INDEX

-- Name: ix_kxp_entity_role_map_soid; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_entity_role_map_soid ON labkxp.labkxp_entity_role_map USING btree (source_object_id);


--
