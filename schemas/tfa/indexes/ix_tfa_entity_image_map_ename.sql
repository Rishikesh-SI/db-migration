-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_entity_image_map_ename
-- Type: INDEX

-- Name: ix_tfa_entity_image_map_ename; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_entity_image_map_ename ON tfa.tfa_entity_image_map USING btree (entity_master_id);


--
