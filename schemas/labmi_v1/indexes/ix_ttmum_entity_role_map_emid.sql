-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labmi_v1.labmi_v1_entity_role_map USING btree (entity_master_id);


--
