-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_upy_asset_list_title_alias_lower; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_asset_list_title_alias_lower ON upy.upy_asset_list USING btree (lower((title_alias)::text));


--
