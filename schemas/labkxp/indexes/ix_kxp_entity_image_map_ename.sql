-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_entity_image_map_ename
-- Type: INDEX

-- Name: ix_kxp_entity_image_map_ename; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_entity_image_map_ename ON labkxp.labkxp_entity_image_map USING btree (entity_master_id);


--
