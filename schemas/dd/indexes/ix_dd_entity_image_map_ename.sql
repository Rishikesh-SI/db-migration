-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_entity_image_map_ename
-- Type: INDEX

-- Name: ix_dd_entity_image_map_ename; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_entity_image_map_ename ON dd.dd_entity_image_map USING btree (entity_master_id);


--
