-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_asset_list_sermid
-- Type: INDEX

-- Name: ix_upy_asset_list_sermid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_asset_list_sermid ON upy.upy_asset_list USING btree (secondary_entity_role_map_id);


--
