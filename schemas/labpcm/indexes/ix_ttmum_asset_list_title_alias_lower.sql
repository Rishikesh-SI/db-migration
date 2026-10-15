-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: ix_ttmum_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias_lower; Type: INDEX; Schema: labpcm; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias_lower ON labpcm.labpcm_asset_list USING btree (lower((title_alias)::text));


--
