-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON labecn_v1_bkp_29012025.labecn_v1_asset_list USING btree (title_alias);


--
