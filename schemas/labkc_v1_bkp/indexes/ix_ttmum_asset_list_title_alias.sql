-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: labkc_v1_bkp; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON labkc_v1_bkp.labkc_v1_asset_list USING btree (title_alias);


--
