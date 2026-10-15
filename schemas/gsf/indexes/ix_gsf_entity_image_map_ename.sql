-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_entity_image_map_ename
-- Type: INDEX

-- Name: ix_gsf_entity_image_map_ename; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_entity_image_map_ename ON gsf.gsf_entity_image_map USING btree (entity_master_id);


--
