-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_spz_asset_list_title_alias_lower; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_asset_list_title_alias_lower ON spz.spz_asset_list USING btree (lower((title_alias)::text));


--
