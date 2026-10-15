-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_pkl_asset_list_title_alias_lower; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_asset_list_title_alias_lower ON msl.msl_asset_list USING btree (lower((title_alias)::text));


--
