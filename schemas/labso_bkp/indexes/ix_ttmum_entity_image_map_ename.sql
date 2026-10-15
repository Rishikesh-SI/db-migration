-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: ix_ttmum_entity_image_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_image_map_ename; Type: INDEX; Schema: labso_bkp; Owner: -
--

CREATE INDEX ix_ttmum_entity_image_map_ename ON labso_bkp.labso_entity_image_map USING btree (entity_master_id);


--
