-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ix_ttmum_entity_role_map_erid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_erid; Type: INDEX; Schema: ttmum; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_erid ON ttmum.ttmum_entity_role_map USING btree (entity_role_id);


--
