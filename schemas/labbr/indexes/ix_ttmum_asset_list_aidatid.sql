-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: ix_ttmum_asset_list_aidatid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_aidatid; Type: INDEX; Schema: labbr; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_aidatid ON labbr.labbr_asset_list USING btree (asset_id, asset_type_id);


--
