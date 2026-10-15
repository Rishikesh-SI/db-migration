-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_rfg_asset_list_title_alias_lower; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_asset_list_title_alias_lower ON rfg.rfg_asset_list USING btree (lower((title_alias)::text));


--
