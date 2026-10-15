-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_pbl_asset_list_title_alias_lower; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_asset_list_title_alias_lower ON pbl.pbl_asset_list USING btree (lower((title_alias)::text));


--
