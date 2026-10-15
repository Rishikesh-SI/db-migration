-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: labbsc_old; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON labbsc_old.labbsc_asset_list USING btree (title_alias);


--
