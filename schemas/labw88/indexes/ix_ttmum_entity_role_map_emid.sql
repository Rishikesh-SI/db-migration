-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labw88.labw88_entity_role_map USING btree (entity_master_id);


--
