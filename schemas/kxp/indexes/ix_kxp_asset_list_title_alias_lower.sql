-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_kxp_asset_list_title_alias_lower; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_asset_list_title_alias_lower ON kxp.kxp_asset_list USING btree (lower((title_alias)::text));


--
