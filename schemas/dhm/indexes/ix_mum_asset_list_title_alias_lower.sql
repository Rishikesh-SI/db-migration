-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_mum_asset_list_title_alias_lower; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_asset_list_title_alias_lower ON dhm.dhm_asset_list USING btree (lower((title_alias)::text));


--
