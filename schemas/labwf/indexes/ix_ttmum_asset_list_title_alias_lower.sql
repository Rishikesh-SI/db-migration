-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: ix_ttmum_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias_lower; Type: INDEX; Schema: labwf; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias_lower ON labwf.labwf_asset_list USING btree (lower((title_alias)::text));


--
