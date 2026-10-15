-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labkc_v1_02042024; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labkc_v1_02042024.labkc_v1_entity_role_map USING btree (entity_master_id);


--
