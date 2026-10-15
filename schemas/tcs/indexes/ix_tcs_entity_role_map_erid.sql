-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_entity_role_map_erid
-- Type: INDEX

-- Name: ix_tcs_entity_role_map_erid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_entity_role_map_erid ON tcs.tcs_entity_role_map USING btree (entity_role_id);


--
