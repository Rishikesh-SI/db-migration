-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: ix_ttmum_entity_image_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_image_map_ename; Type: INDEX; Schema: labpc; Owner: -
--

CREATE INDEX ix_ttmum_entity_image_map_ename ON labpc.labpc_entity_image_map USING btree (entity_master_id);


--
