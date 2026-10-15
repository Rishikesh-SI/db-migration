-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_asset_list_aidatid
-- Type: INDEX

-- Name: ix_kxp_asset_list_aidatid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_asset_list_aidatid ON kxp.kxp_asset_list USING btree (asset_id, asset_type_id);


--
