-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_dd_asset_list_title_alias_lower; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_asset_list_title_alias_lower ON dd.dd_asset_list USING btree (lower((title_alias)::text));


--
