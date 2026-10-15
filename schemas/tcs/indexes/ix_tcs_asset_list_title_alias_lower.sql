-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_tcs_asset_list_title_alias_lower; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_asset_list_title_alias_lower ON tcs.tcs_asset_list USING btree (lower((title_alias)::text));


--
