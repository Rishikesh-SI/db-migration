-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_entity_image_map_ename
-- Type: INDEX

-- Name: ix_kxp_entity_image_map_ename; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_entity_image_map_ename ON labstlz.labstlz_entity_image_map USING btree (entity_master_id);


--
