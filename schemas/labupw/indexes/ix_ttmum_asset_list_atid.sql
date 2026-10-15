-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: ix_ttmum_asset_list_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_atid; Type: INDEX; Schema: labupw; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_atid ON labupw.labupw_asset_list USING btree (asset_type_id);


--
