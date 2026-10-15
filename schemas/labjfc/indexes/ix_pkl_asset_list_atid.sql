-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_asset_list_atid
-- Type: INDEX

-- Name: ix_pkl_asset_list_atid; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_asset_list_atid ON labjfc.labjfc_asset_list USING btree (asset_type_id);


--
