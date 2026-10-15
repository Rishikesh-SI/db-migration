-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp07062024
-- Object: ix_ttmum_entity_role_map_soid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_soid; Type: INDEX; Schema: labecn_bkp07062024; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_soid ON labecn_bkp07062024.labecn_entity_role_map USING btree (source_object_id);


--
