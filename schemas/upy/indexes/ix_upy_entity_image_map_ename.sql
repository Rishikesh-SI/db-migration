-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_entity_image_map_ename
-- Type: INDEX

-- Name: ix_upy_entity_image_map_ename; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_entity_image_map_ename ON upy.upy_entity_image_map USING btree (entity_master_id);


--
