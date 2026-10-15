-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_ttmum_asset_list_sermid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_sermid; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_sermid ON labpvl.labpvl_asset_list USING btree (secondary_entity_role_map_id);


--
