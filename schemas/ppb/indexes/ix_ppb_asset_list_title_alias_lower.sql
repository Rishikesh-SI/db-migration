-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_ppb_asset_list_title_alias_lower; Type: INDEX; Schema: ppb; Owner: -
--

CREATE UNIQUE INDEX ix_ppb_asset_list_title_alias_lower ON ppb.ppb_asset_list USING btree (lower((title_alias)::text));


--
