-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_asset_list_title_alias
-- Type: INDEX

-- Name: ix_tfa_asset_list_title_alias; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_asset_list_title_alias ON tfa.tfa_asset_list USING btree (title_alias);


--
