-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_cfc_asset_list_title_alias_lower; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_asset_list_title_alias_lower ON cfc.cfc_asset_list USING btree (lower((title_alias)::text));


--
