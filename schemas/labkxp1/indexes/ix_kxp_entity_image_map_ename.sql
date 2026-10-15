-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_entity_image_map_ename
-- Type: INDEX

-- Name: ix_kxp_entity_image_map_ename; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_entity_image_map_ename ON labkxp1.labkxp_entity_image_map USING btree (entity_master_id);


--
