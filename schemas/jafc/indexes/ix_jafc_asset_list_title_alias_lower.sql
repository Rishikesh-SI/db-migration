-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_jafc_asset_list_title_alias_lower; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_asset_list_title_alias_lower ON jafc.jafc_asset_list USING btree (lower((title_alias)::text));


--
