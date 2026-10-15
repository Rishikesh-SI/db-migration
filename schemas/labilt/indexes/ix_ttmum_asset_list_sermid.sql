-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: ix_ttmum_asset_list_sermid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_sermid; Type: INDEX; Schema: labilt; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_sermid ON labilt.labilt_asset_list USING btree (secondary_entity_role_map_id);


--
