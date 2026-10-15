-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: ix_ttmum_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias_lower; Type: INDEX; Schema: labfg; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias_lower ON labfg.labfg_asset_list USING btree (lower((title_alias)::text));


--
