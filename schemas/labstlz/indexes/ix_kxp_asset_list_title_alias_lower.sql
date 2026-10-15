-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_kxp_asset_list_title_alias_lower; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_asset_list_title_alias_lower ON labstlz.labstlz_asset_list USING btree (lower((title_alias)::text));


--
