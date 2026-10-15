-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_entity_image_map_ename
-- Type: INDEX

-- Name: ix_rfg_entity_image_map_ename; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_entity_image_map_ename ON rfg.rfg_entity_image_map USING btree (entity_master_id);


--
