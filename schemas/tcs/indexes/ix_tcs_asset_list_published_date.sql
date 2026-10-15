-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_asset_list_published_date
-- Type: INDEX

-- Name: ix_tcs_asset_list_published_date; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_asset_list_published_date ON tcs.tcs_asset_list USING btree (published_date);


--
