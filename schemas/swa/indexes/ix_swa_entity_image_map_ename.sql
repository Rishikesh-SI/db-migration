-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_entity_image_map_ename
-- Type: INDEX

-- Name: ix_swa_entity_image_map_ename; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_entity_image_map_ename ON swa.swa_entity_image_map USING btree (entity_master_id);


--
