-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_kxp_asset_list_title_alias_lower; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_asset_list_title_alias_lower ON labkxp.labkxp_asset_list USING btree (lower((title_alias)::text));


--
