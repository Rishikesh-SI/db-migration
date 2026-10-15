-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: labwafdemo; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON labwafdemo.labwafdemo_asset_list USING btree (title_alias);


--
