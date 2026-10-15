-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: ix_ttmum_entity_role_map_soid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_soid; Type: INDEX; Schema: labgt_bkp; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_soid ON labgt_bkp.labgt_entity_role_map USING btree (source_object_id);


--
