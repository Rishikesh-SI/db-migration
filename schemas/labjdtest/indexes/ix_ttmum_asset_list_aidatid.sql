-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: ix_ttmum_asset_list_aidatid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_aidatid; Type: INDEX; Schema: labjdtest; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_aidatid ON labjdtest.labjdtest_asset_list USING btree (asset_id, asset_type_id);


--
