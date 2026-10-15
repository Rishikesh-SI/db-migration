-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_tsk_asset_list_title_alias_lower; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_asset_list_title_alias_lower ON tsk.tsk_asset_list USING btree (lower((title_alias)::text));


--
