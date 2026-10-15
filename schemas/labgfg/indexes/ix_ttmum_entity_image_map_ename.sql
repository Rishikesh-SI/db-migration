-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: ix_ttmum_entity_image_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_image_map_ename; Type: INDEX; Schema: labgfg; Owner: -
--

CREATE INDEX ix_ttmum_entity_image_map_ename ON labgfg.labgfg_entity_image_map USING btree (entity_master_id);


--
