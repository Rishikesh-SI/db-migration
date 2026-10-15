-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: ix_ttmum_asset_list_aidatid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_aidatid; Type: INDEX; Schema: lablakr; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_aidatid ON lablakr.lablakr_asset_list USING btree (asset_id, asset_type_id);


--
