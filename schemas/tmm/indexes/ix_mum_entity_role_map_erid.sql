-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_entity_role_map_erid
-- Type: INDEX

-- Name: ix_mum_entity_role_map_erid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_entity_role_map_erid ON tmm.tmm_entity_role_map USING btree (entity_role_id);


--
