-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_tsk_asset_list_title_alias_lower; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_asset_list_title_alias_lower ON labtcs.labtcs_asset_list USING btree (lower((title_alias)::text));


--
