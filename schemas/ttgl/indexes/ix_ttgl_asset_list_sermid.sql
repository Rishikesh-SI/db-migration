-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_asset_list_sermid
-- Type: INDEX

-- Name: ix_ttgl_asset_list_sermid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_asset_list_sermid ON ttgl.ttgl_asset_list USING btree (secondary_entity_role_map_id);


--
