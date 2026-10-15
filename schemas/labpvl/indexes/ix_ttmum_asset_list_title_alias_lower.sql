-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_ttmum_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias_lower; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias_lower ON labpvl.labpvl_asset_list USING btree (lower((title_alias)::text));


--
