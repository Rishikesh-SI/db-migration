-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: ix_ttmum_entity_image_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_image_map_ename; Type: INDEX; Schema: labtmum; Owner: -
--

CREATE INDEX ix_ttmum_entity_image_map_ename ON labtmum.labtmum_entity_image_map USING btree (entity_master_id);


--
