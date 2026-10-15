-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_asset_list_title_alias
-- Type: INDEX

-- Name: ix_tcs_asset_list_title_alias; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_asset_list_title_alias ON tcs.tcs_asset_list USING btree (title_alias);


--
