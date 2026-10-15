-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: ix_ttmum_entity_image_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_image_map_ename; Type: INDEX; Schema: labpr; Owner: -
--

CREATE INDEX ix_ttmum_entity_image_map_ename ON labpr.labpr_entity_image_map USING btree (entity_master_id);


--
