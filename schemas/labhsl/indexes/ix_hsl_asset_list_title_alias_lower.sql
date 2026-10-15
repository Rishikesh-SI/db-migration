-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_hsl_asset_list_title_alias_lower; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_asset_list_title_alias_lower ON labhsl.labhsl_asset_list USING btree (lower((title_alias)::text));


--
