-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: labmao_bkp; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON labmao_bkp.labmao_asset_list USING btree (title_alias);


--
