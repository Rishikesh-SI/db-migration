-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_asset_list_title_alias
-- Type: INDEX

-- Name: ix_hsl_asset_list_title_alias; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_asset_list_title_alias ON hsl.hsl_asset_list USING btree (title_alias);


--
