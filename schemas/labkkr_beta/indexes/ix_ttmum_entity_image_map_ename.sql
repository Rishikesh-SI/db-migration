-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: ix_ttmum_entity_image_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_image_map_ename; Type: INDEX; Schema: labkkr_beta; Owner: -
--

CREATE INDEX ix_ttmum_entity_image_map_ename ON labkkr_beta.labkkr_entity_image_map USING btree (entity_master_id);


--
