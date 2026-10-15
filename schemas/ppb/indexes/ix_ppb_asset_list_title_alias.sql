-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ppb_asset_list_title_alias; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_asset_list_title_alias ON ppb.ppb_asset_list USING btree (title_alias);


--
