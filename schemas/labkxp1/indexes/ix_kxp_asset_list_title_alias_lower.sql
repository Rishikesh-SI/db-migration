-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_kxp_asset_list_title_alias_lower; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_asset_list_title_alias_lower ON labkxp1.labkxp_asset_list USING btree (lower((title_alias)::text));


--
