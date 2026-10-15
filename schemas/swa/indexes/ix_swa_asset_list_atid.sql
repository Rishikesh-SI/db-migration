-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_asset_list_atid
-- Type: INDEX

-- Name: ix_swa_asset_list_atid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_asset_list_atid ON swa.swa_asset_list USING btree (asset_type_id);


--
