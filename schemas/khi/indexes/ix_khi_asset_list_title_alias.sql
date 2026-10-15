-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_asset_list_title_alias
-- Type: INDEX

-- Name: ix_khi_asset_list_title_alias; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_asset_list_title_alias ON khi.khi_asset_list USING btree (title_alias);


--
