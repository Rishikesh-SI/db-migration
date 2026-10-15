-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON labrstg.labrstg_asset_list USING btree (title_alias);


--
