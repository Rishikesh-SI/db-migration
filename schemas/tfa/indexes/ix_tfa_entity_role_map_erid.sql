-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_entity_role_map_erid
-- Type: INDEX

-- Name: ix_tfa_entity_role_map_erid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_entity_role_map_erid ON tfa.tfa_entity_role_map USING btree (entity_role_id);


--
