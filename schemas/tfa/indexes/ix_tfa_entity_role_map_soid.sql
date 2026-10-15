-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_entity_role_map_soid
-- Type: INDEX

-- Name: ix_tfa_entity_role_map_soid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_entity_role_map_soid ON tfa.tfa_entity_role_map USING btree (source_object_id);


--
