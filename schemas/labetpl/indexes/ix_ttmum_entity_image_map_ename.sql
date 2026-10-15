-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: ix_ttmum_entity_image_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_image_map_ename; Type: INDEX; Schema: labetpl; Owner: -
--

CREATE INDEX ix_ttmum_entity_image_map_ename ON labetpl.labetpl_entity_image_map USING btree (entity_master_id);


--
