-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: lablakr; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON lablakr.lablakr_asset_list USING btree (title_alias);


--
