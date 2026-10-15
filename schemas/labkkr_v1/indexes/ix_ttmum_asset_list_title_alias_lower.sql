-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: ix_ttmum_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias_lower; Type: INDEX; Schema: labkkr_v1; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias_lower ON labkkr_v1.labkkr_v1_asset_list USING btree (lower((title_alias)::text));


--
