-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: ix_ttmum_entity_role_map_erid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_erid; Type: INDEX; Schema: labgmr_01082024; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_erid ON labgmr_01082024.labgmr_entity_role_map USING btree (entity_role_id);


--
