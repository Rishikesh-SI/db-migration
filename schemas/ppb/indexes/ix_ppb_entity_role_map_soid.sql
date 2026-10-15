-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_entity_role_map_soid
-- Type: INDEX

-- Name: ix_ppb_entity_role_map_soid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_entity_role_map_soid ON ppb.ppb_entity_role_map USING btree (source_object_id);


--
