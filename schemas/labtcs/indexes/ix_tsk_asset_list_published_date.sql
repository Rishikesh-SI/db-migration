-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_asset_list_published_date
-- Type: INDEX

-- Name: ix_tsk_asset_list_published_date; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_asset_list_published_date ON labtcs.labtcs_asset_list USING btree (published_date);


--
