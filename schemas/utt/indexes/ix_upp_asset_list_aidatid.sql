-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_asset_list_aidatid
-- Type: INDEX

-- Name: ix_upp_asset_list_aidatid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_asset_list_aidatid ON utt.utt_asset_list USING btree (asset_id, asset_type_id);


--
