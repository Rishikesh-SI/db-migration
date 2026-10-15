-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_asset_list_aid
-- Type: INDEX

-- Name: ix_stn_asset_list_aid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_asset_list_aid ON stn.stn_asset_list USING btree (asset_id);


--
