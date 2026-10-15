-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: ix_ttmum_asset_list_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_atid; Type: INDEX; Schema: labbsc; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_atid ON labbsc.labbsc_asset_list USING btree (asset_type_id);


--
