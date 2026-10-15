-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_entity_image_map_ename
-- Type: INDEX

-- Name: ix_khi_entity_image_map_ename; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_entity_image_map_ename ON khi.khi_entity_image_map USING btree (entity_master_id);


--
