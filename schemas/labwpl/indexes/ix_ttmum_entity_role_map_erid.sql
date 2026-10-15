-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: ix_ttmum_entity_role_map_erid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_erid; Type: INDEX; Schema: labwpl; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_erid ON labwpl.labwpl_entity_role_map USING btree (entity_role_id);


--
