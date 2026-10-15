-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: ix_ttmum_asset_list_sermid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_sermid; Type: INDEX; Schema: labdv; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_sermid ON labdv.labdv_asset_list USING btree (secondary_entity_role_map_id);


--
