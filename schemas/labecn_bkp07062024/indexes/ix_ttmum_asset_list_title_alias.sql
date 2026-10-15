-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp07062024
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: labecn_bkp07062024; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON labecn_bkp07062024.labecn_asset_list USING btree (title_alias);


--
