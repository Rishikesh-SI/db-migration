-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_zeven_asset_list_title_alias_lower; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_asset_list_title_alias_lower ON zeven.zeven_asset_list USING btree (lower((title_alias)::text));


--
