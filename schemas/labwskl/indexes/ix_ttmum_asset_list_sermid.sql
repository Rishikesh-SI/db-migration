-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: ix_ttmum_asset_list_sermid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_sermid; Type: INDEX; Schema: labwskl; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_sermid ON labwskl.labwskl_asset_list USING btree (secondary_entity_role_map_id);


--
