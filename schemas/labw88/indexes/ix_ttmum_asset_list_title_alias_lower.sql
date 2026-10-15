-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias_lower; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias_lower ON labw88.labw88_asset_list USING btree (lower((title_alias)::text));


--
