-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_asset_list_published_date
-- Type: INDEX

-- Name: ix_tsk_asset_list_published_date; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_asset_list_published_date ON tsk.tsk_asset_list USING btree (published_date);


--
