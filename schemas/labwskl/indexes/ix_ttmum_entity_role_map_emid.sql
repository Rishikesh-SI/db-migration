-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labwskl; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labwskl.labwskl_entity_role_map USING btree (entity_master_id);


--
