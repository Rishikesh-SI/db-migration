-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_asset_list_title_alias
-- Type: INDEX

-- Name: ix_gsf_asset_list_title_alias; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_asset_list_title_alias ON gsf.gsf_asset_list USING btree (title_alias);


--
