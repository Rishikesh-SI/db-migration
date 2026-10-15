-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: labbr; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON labbr.labbr_asset_list USING btree (title_alias);


--
