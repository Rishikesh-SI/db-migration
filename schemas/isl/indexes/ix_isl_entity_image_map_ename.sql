-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_entity_image_map_ename
-- Type: INDEX

-- Name: ix_isl_entity_image_map_ename; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_entity_image_map_ename ON isl.isl_entity_image_map USING btree (entity_master_id);


--
