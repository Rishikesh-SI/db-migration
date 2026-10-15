-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_entity_image_map_ename
-- Type: INDEX

-- Name: ix_pkl_entity_image_map_ename; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_entity_image_map_ename ON msl.msl_entity_image_map USING btree (entity_master_id);


--
