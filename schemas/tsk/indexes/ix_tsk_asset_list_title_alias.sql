-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_asset_list_title_alias
-- Type: INDEX

-- Name: ix_tsk_asset_list_title_alias; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_asset_list_title_alias ON tsk.tsk_asset_list USING btree (title_alias);


--
