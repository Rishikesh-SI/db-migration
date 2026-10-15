-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_asset_list_atid
-- Type: INDEX

-- Name: ix_abp_asset_list_atid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_asset_list_atid ON abpp.abp_asset_list USING btree (asset_type_id);


--
