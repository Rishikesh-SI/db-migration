-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_asset_list_published_date
-- Type: INDEX

-- Name: ix_ppb_asset_list_published_date; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_asset_list_published_date ON ppb.ppb_asset_list USING btree (published_date);


--
