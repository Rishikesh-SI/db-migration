-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labwf; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labwf.labwf_entity_role_map USING btree (entity_master_id);


--
