-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_asset_list_aidatid
-- Type: INDEX

-- Name: ix_tfa_asset_list_aidatid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_asset_list_aidatid ON tfa.tfa_asset_list USING btree (asset_id, asset_type_id);


--
