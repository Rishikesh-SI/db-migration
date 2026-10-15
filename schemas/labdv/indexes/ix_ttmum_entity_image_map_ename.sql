-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: ix_ttmum_entity_image_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_image_map_ename; Type: INDEX; Schema: labdv; Owner: -
--

CREATE INDEX ix_ttmum_entity_image_map_ename ON labdv.labdv_entity_image_map USING btree (entity_master_id);


--
