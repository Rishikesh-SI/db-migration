-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: ix_ttmum_asset_list_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_atid; Type: INDEX; Schema: labrg; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_atid ON labrg.labrg_asset_list USING btree (asset_type_id);


--
