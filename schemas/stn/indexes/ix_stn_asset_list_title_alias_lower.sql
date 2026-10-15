-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_stn_asset_list_title_alias_lower; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_asset_list_title_alias_lower ON stn.stn_asset_list USING btree (lower((title_alias)::text));


--
