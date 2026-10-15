-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_entity_image_map_ename
-- Type: INDEX

-- Name: ix_hsl_entity_image_map_ename; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_entity_image_map_ename ON labhsl.labhsl_entity_image_map USING btree (entity_master_id);


--
