-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_asset_list_atid
-- Type: INDEX

-- Name: ix_stn_asset_list_atid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_asset_list_atid ON stn.stn_asset_list USING btree (asset_type_id);


--
