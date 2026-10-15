-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_asset_list_atid
-- Type: INDEX

-- Name: ix_pkl_asset_list_atid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_asset_list_atid ON pkl.pkl_asset_list USING btree (asset_type_id);


--
