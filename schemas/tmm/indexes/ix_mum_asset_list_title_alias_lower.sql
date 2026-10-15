-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_mum_asset_list_title_alias_lower; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_asset_list_title_alias_lower ON tmm.tmm_asset_list USING btree (lower((title_alias)::text));


--
