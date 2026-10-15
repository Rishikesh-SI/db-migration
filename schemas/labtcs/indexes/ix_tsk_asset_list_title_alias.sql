-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_asset_list_title_alias
-- Type: INDEX

-- Name: ix_tsk_asset_list_title_alias; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_asset_list_title_alias ON labtcs.labtcs_asset_list USING btree (title_alias);


--
