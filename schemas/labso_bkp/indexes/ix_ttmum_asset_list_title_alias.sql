-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: labso_bkp; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON labso_bkp.labso_asset_list USING btree (title_alias);


--
