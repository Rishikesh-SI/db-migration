-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_tfa_asset_list_title_alias_lower; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_asset_list_title_alias_lower ON tfa.tfa_asset_list USING btree (lower((title_alias)::text));


--
