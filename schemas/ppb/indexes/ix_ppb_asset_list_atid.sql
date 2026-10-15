-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_asset_list_atid
-- Type: INDEX

-- Name: ix_ppb_asset_list_atid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_asset_list_atid ON ppb.ppb_asset_list USING btree (asset_type_id);


--
