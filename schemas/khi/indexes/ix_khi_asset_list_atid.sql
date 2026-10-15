-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_asset_list_atid
-- Type: INDEX

-- Name: ix_khi_asset_list_atid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_asset_list_atid ON khi.khi_asset_list USING btree (asset_type_id);


--
