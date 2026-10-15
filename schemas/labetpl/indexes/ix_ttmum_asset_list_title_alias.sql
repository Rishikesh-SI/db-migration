-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: labetpl; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON labetpl.labetpl_asset_list USING btree (title_alias);


--
