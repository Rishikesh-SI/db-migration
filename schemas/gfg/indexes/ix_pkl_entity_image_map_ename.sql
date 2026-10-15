-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_entity_image_map_ename
-- Type: INDEX

-- Name: ix_pkl_entity_image_map_ename; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_entity_image_map_ename ON gfg.gfg_entity_image_map USING btree (entity_master_id);


--
