-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: labgg; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON labgg.labgg_asset_list USING btree (title_alias);


--
