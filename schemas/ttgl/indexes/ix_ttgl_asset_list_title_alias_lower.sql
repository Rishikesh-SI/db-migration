-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_ttgl_asset_list_title_alias_lower; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_asset_list_title_alias_lower ON ttgl.ttgl_asset_list USING btree (lower((title_alias)::text));


--
