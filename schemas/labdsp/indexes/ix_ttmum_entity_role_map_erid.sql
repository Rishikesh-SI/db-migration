-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: ix_ttmum_entity_role_map_erid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_erid; Type: INDEX; Schema: labdsp; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_erid ON labdsp.labdsp_entity_role_map USING btree (entity_role_id);


--
