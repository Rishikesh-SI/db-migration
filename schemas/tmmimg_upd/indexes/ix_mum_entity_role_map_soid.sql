-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_entity_role_map_soid
-- Type: INDEX

-- Name: ix_mum_entity_role_map_soid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_entity_role_map_soid ON tmmimg_upd.tmmimg_upd_entity_role_map USING btree (source_object_id);


--
